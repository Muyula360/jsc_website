import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";


// Initial state
const initialState = { websiteVisits: [], isLoading:false, isSuccess:false, isError:false, message:'' }


// Post new website visit
export const postWebsiteVisit = createAsyncThunk('websiteVisit/postVisit', async (_, thunkAPI) => {

    //access states from store to get csrfToken
    const state = thunkAPI.getState();
    const csrfToken = state.csrf.csrfToken;

    try {
        const API_URL = `/api/websiteVisit/postVisit`;

        const response = await axios.post(API_URL,'' ,{ headers:{'X-CSRF-Token': csrfToken}, withCredentials: false });

        return response.data;

    } catch (error) {
        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString();
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


// Retrieve website visits stats --> when website loads (dispatch getWebsiteVisitStats) this function is invoked and send get request to the getVisitsStats endpoint using axios
export const getWebsiteVisitStats = createAsyncThunk('websiteVisit/getVisitsStats', async (_, thunkAPI) => {
    try{
        const API_URL = `/api/websiteVisit/getVisitsStats`;

        const response = await axios.get(API_URL);

        return response.data;
              
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});




//websitevisit slice
export const websiteVisitSlice = createSlice({
    name: 'websiteVisit',
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
        .addCase(getWebsiteVisitStats.pending, (state) => { state.isLoading = true; })
        .addCase(getWebsiteVisitStats.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.websiteVisits = action.payload; })
        .addCase(getWebsiteVisitStats.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.websiteVisits = null })
        
        .addCase(postWebsiteVisit.pending, (state) => { state.isLoading = true; })
        .addCase(postWebsiteVisit.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.message = 'Visit recorded successfully'; })
        .addCase(postWebsiteVisit.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; })
    },
}); 

export const { reset } = websiteVisitSlice.actions
export default websiteVisitSlice.reducer // export slice reducer --> store it in app/store.js.