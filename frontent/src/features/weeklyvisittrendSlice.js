import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from 'axios';

// initial State
const initialState = { weeklyVisitsTrends: '', isLoading:false, isSuccess:false, isError:false, message:'' }


// retrieve weeklyVisitsTrends --> when website content manager loads (dispatch getweeklyVisitsTrends) this function is invoked and send get request to the weeklyVisitsTrends endpoint using axios
export const getWeeklyVisitsTrends = createAsyncThunk('trends/weeklyVisitsTrends', async (_, thunkAPI) => {
    try{
        const API_URL = `/api/trends/weeklyVisitsTrends`;

        const response = await axios.get(API_URL);

        return response.data;
              
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


// create weeklyVisitsTrends slice
export const weeklyVisitsTrendSlice = createSlice({
    name: 'weeklyVisitsTrends',
    initialState,
    reducers: {

        resetWeeklyVisitsTrends: (state) => initialState
        
    },
    extraReducers: (builder) => {
        builder
        .addCase(getWeeklyVisitsTrends.pending, (state) => { state.isLoading=true; })
        .addCase(getWeeklyVisitsTrends.fulfilled, (state, action) => { state.isLoading=false; state.isSuccess=true; state.weeklyVisitsTrends=action.payload; })
        .addCase(getWeeklyVisitsTrends.rejected, (state, action) => { state.isLoading=false; state.isError=true; state.message=action.payload; state.weeklyVisitsTrends=[] })      
    }
}); 

export const { resetWeeklyVisitsTrends } = weeklyVisitsTrendSlice.actions
export default weeklyVisitsTrendSlice.reducer //after exporting slice reducer --> store it in app/store.js.