import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from 'axios';

// initial State
const initialState = { contenthighlights: '', isLoading:false, isSuccess:false, isError:false, message:'' }


// retrieve Contenthighlights --> when website content manager loads (dispatch getContenthighlights) this function is invoked and send get request to the contenthighlights endpoint using axios
export const getContenthighlights = createAsyncThunk('trends/getcontenthighlights', async (_, thunkAPI) => {
    try{
        const API_URL = `/api/trends/contenthighlights`;

        const response = await axios.get(API_URL);

        return response.data;
              
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


// create contenthighlight slice
export const contenthighlightSlice = createSlice({
    name: 'contenthighlights',
    initialState,
    reducers: {

        resetContenthighlights: (state) => initialState
        
    },
    extraReducers: (builder) => {
        builder
        .addCase(getContenthighlights.pending, (state) => { state.isLoading=true; })
        .addCase(getContenthighlights.fulfilled, (state, action) => { state.isLoading=false; state.isSuccess=true; state.contenthighlights=action.payload; })
        .addCase(getContenthighlights.rejected, (state, action) => { state.isLoading=false; state.isError=true; state.message=action.payload; state.contenthighlights=[] })      
    }
}); 

export const { resetContenthighlights } = contenthighlightSlice.actions
export default contenthighlightSlice.reducer //after exporting slice reducer --> store it in app/store.js.