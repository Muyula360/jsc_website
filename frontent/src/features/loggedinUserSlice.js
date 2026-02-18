import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { loggedinUser: [], isLoading:false, isSuccess:false, isError:false, message:'' }



// Retrieve user details --> when user login successed (dispatch getLoggedinUserDetails) this function is invoked and send get request to the getMyDetails endpoint using axios
export const getLoggedinUserDetails = createAsyncThunk('loggedinUser/getDetails', async (_, thunkAPI) => {
    try{
        const API_URL = `/api/user/getMyDetails`;

        const response = await axios.get(API_URL);

        return response.data;
                     
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


//loggedin User slice
export const loggedinUserSlice = createSlice({
    name: 'loggedinUser',
    initialState,
    reducers: {

        reset: (state) => { 
            state.isLoading = false; 
            state.isError = false; 
            state.isSuccess = false; 
            state.message = '' 
        }
    },
    extraReducers: (builder) => {
        builder
        .addCase(getLoggedinUserDetails.pending, (state) => { state.isLoading = true; })
        .addCase(getLoggedinUserDetails.fulfilled, (state, action) => { state.isLoading = false; state.isError = false; state.isSuccess = true; state.loggedinUser = action.payload;  })
        .addCase(getLoggedinUserDetails.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.isSuccess = false; state.message = action.payload; })
    },
}); 

export const { reset } = loggedinUserSlice.actions
export default loggedinUserSlice.reducer // export slice reducer --> store it in app/store.js.