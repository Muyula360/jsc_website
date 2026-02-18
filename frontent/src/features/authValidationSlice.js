import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";


// initial State
const initialState = { validatedUser:null, isLoading:false, isSuccess:false, isError:false, message:'' }



// validate authToken --> at any time while user is loggedin (dispatch authTokenValidation) this function checks whether user's authToken still valid
export const authTokenValidation = createAsyncThunk('user/authValidation', async (_, thunkAPI) => {

    try{
        const API_URL = `/api/auth/authValidation`;

        const response = await axios.get(API_URL);

        return response.data;
                     
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


// authValidation Slice
export const authValidationSlice = createSlice({
    name: 'authValidation',
    initialState,
    reducers: {

        reset: (state) => { 
            state.validatedUser = null;
            state.isLoading = false; 
            state.isError = false; 
            state.isSuccess = false; 
            state.message = '' 
        }
    },
    extraReducers: (builder) => {
        builder
        .addCase(authTokenValidation.pending, (state) => { state.isLoading = true; })
        .addCase(authTokenValidation.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.validatedUser = action.payload; })
        .addCase(authTokenValidation.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.validatedUser = null; state.message = action.payload;  })        
    },
}); 

export const { reset } = authValidationSlice.actions
export default authValidationSlice.reducer // export slice reducer --> store it in app/store.js.