import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";


// declare initialState
const initialState = { resetPassword: null, resetPasswordLoading:false, resetPasswordSuccess:false, resetPasswordError:false, resetPasswordMessage:'' }



// this function is invoked when user clicks 'resetPassword' button --> (dispatch resetPassword), when this function is invoked it sends post request to the '/resetPassword' endpoint using axios
export const resetUserPassword = createAsyncThunk('forgotPassword/resetUserPassword', async (resetPasswordData, thunkAPI) => {

    //access states from store to get csrfToken
    const state = thunkAPI.getState();
    const csrfToken = state.csrf.csrfToken;
  
    try{
      
        const API_URL = `/api/auth/resetPassword`
        const response = await axios.post(API_URL, resetPasswordData, { headers:{'X-CSRF-Token': csrfToken}, withCredentials: false });

        return response.data

    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || errorstate.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});



// reset password slice
export const resetPasswordSlice = createSlice({
    name: 'resetPassword',
    initialState,
    reducers: {

        reset: (state) => { 
            state.resetPassword = null;
            state.resetPasswordLoading = false; 
            state.resetPasswordError = false; 
            state.resetPasswordSuccess = false; 
            state.resetPasswordMessage = '' 
        }
    },
    extraReducers: (builder) => {
        builder
        .addCase(resetUserPassword.pending, (state) => { state.resetPasswordLoading = true; })
        .addCase(resetUserPassword.fulfilled, (state, action) => { state.resetPasswordLoading = false; state.resetPasswordError = false; state.resetPasswordSuccess = true; state.resetPassword = action.payload; })
        .addCase(resetUserPassword.rejected, (state, action) => { state.resetPasswordLoading = false; state.resetPasswordError = true; state.resetPasswordMessage = action.payload; })
    
    },
}); 

export const { reset } = resetPasswordSlice.actions
export default resetPasswordSlice.reducer // export slice reducer --> store it in app/store.js.