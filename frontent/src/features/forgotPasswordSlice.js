import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";


// declare initialState
const initialState = { resetLink: null, resetLinkLoading:false, resetLinkSuccess:false, resetLinkError:false, resetLinkMessage:'' }



// this function is invoked when user clicks 'send password reset email' button --> (dispatch generateResetPasswordLink) when this function is invoked it sends post request to the 'forgotPassword' endpoint using axios
export const generateResetPasswordLink = createAsyncThunk('forgotPassword/generatePasswordResetLink', async (resetPasswordEmail, thunkAPI) => {

    //access states from store to get csrfToken
    const state = thunkAPI.getState();
    const csrfToken = state.csrf.csrfToken;
  
    try{
      
        const API_URL = `/api/auth/forgotPassword`
        const response = await axios.post(API_URL, resetPasswordEmail, { headers:{'X-CSRF-Token': csrfToken}, withCredentials: false });

        return response.data

    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || errorstate.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});



// forgot password slice
export const forgotPasswordSlice = createSlice({
    name: 'forgotPassword',
    initialState,
    reducers: {

        resetForgotPassword: (state) => { 
            state.resetLink = null;
            state.resetLinkLoading = false; 
            state.resetLinkError = false; 
            state.resetLinkSuccess = false; 
            state.resetLinkMessage = '' 
        }
    },
    extraReducers: (builder) => {
        builder
        .addCase(generateResetPasswordLink.pending, (state) => { state.resetLinkLoading = true; })
        .addCase(generateResetPasswordLink.fulfilled, (state, action) => { state.resetLinkLoading = false; state.resetLinkError = false; state.resetLinkSuccess = true; state.resetLink = action.payload; })
        .addCase(generateResetPasswordLink.rejected, (state, action) => { state.resetLinkLoading = false; state.resetLinkError = true; state.resetLinkMessage = action.payload; })
    
    },
}); 

export const { resetForgotPassword } = forgotPasswordSlice.actions
export default forgotPasswordSlice.reducer // export slice reducer --> store it in app/store.js.