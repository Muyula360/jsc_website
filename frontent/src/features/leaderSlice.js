import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { leaders: [], isLoading:false, postLoading:false, isSuccess:false, postSuccess:false, isError:false, postError:false, message:'' }


// Post new leader
export const postLeader = createAsyncThunk('leader/post leader', async (leaderProfile, thunkAPI) => {

    //access states from store to get csrfToken
    const state = thunkAPI.getState();
    const csrfToken = state.csrf.csrfToken;

    try {
        const API_URL = `/api/leader/postLeader`;

        await axios.post(API_URL, leaderProfile, { headers:{'X-CSRF-Token': csrfToken}, withCredentials: false });

        // Return leaders
        const response = await axios.get(`/api/leader/getAllLeaders`);
        return response.data;

    } catch (error) {
        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString();
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


// Retrieve leaders --> when website loads (dispatch getLeaders ) this function is invoked and send get request to the getAllLeaders endpoint using axios
export const getLeaders = createAsyncThunk('leader/getLeaders', async (_, thunkAPI) => {
    try{
        const API_URL = `/api/leader/getAllLeaders`;

        const response = await axios.get(API_URL);

        return response.data;
                     
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});




// leader slice
export const leaderSlice = createSlice({
    name: 'leader',
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
        .addCase(getLeaders.pending, (state) => { state.isLoading = true; })
        .addCase(getLeaders.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.leaders = action.payload; })
        .addCase(getLeaders.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.leaders = null })
        
        .addCase(postLeader.pending, (state) => { state.postLoading = true; })
        .addCase(postLeader.fulfilled, (state, action) => { state.postLoading = false; state.postError = false; state.postSuccess = true; state.leaders = action.payload; state.message = 'Leader posted successfully'; })
        .addCase(postLeader.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })
    },
}); 

export const { reset } = leaderSlice.actions
export default leaderSlice.reducer // export slice reducer --> store it in app/store.js.