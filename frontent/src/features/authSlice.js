import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";


// declare initialState
const initialState = { authToken: null, isLoading:false, isSuccess:false, isError:false, message:'' }



// userAuth user --> when user submits login data (dispatch userAuthentication) this function is invoked and send post request to the login endpoint using axios
export const userAuthentication = createAsyncThunk('user/auth', async (loginCredentials, thunkAPI) => {

    //access states from store to get csrfToken
    const state = thunkAPI.getState();
    const csrfToken = state.csrf.csrfToken;
  
    try{
      
        const API_URL = `/api/auth/login`
        const response = await axios.post(API_URL, loginCredentials, { headers:{'X-CSRF-Token': csrfToken}, withCredentials: false });

        if(response.data){
            
            const now = new Date();
            const data = {
                user: response.data,
                expiry: now.getTime() + 30 * 60 * 1000 // Convert 30 minutes to seconds to milliseconds
            };

            localStorage.setItem('authToken',JSON.stringify(data))
        }

        return response.data

    }catch(error){
        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});



// logout user --> when user click logout (dispatch logout) this function is invoked and send post request to the logout endpoint using axios
export const userLogout = createAsyncThunk('user/logout', async (_, thunkAPI) => {
    try{
        const API_URL = '/api/auth/logout'
        const response = await axios.get(API_URL);

        if(response.data){
            localStorage.clear();
        }

        return response.data
 
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});



// user auth slice
export const userAuthSlice = createSlice({
    name: 'userAuth',
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
        .addCase(userAuthentication.pending, (state) => { state.isLoading = true; })
        .addCase(userAuthentication.fulfilled, (state, action) => { state.isLoading = false; state.isError = false; state.isSuccess = true; state.authToken = action.payload; })
        .addCase(userAuthentication.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.authToken = null })

        .addCase(userLogout.pending, (state) => { state.isLoading = true; })
        .addCase(userLogout.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.authToken = null; })
        .addCase(userLogout.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.authToken = null })        
    },
}); 

export const { reset } = userAuthSlice.actions
export default userAuthSlice.reducer // export slice reducer --> store it in app/store.js.