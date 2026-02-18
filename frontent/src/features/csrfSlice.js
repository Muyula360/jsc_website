import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from 'axios';

// initial State
const initialState = { csrfToken: '', isLoading:false, isSuccess:false, isError:false, message:'' }


//retrieve csrf token --> when website loads (dispatch getCSRFToken) this function is invoked and send get request to the csrf-token endpoint using axios
export const getCSRFToken = createAsyncThunk('csrf/getCSRFToken', async (_, thunkAPI) => {
    try{
        const API_URL = `/api/csrf-token`;

        const response = await axios.get(API_URL);

        return response.data.csrfToken;
              
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


//create slice
export const csrfSlice = createSlice({
    name: 'csrfToken',
    initialState,
    reducers: {

        resetCSRFToken: (state) => initialState
        
    },
    extraReducers: (builder) => {
        builder
        .addCase(getCSRFToken.pending, (state) => { state.isLoading=true; })
        .addCase(getCSRFToken.fulfilled, (state, action) => { state.isLoading=false; state.isSuccess=true; state.csrfToken=action.payload; })
        .addCase(getCSRFToken.rejected, (state, action) => { state.isLoading=false; state.isError=true; state.message=action.payload; state.csrfToken=[] })      
    }
}); 

export const { resetCSRFToken } = csrfSlice.actions
export default csrfSlice.reducer //after exporting slice reducer --> store it in app/store.js.