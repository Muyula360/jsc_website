import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { tenders: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST tender
export const postTender = createAsyncThunk('tender/postTender', async (tenderDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/tender/postTender`;
    await axios.post(API_URL, tenderDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return tender list
    const response = await axios.get(`/api/tender/getAllTenders`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all tenders
export const getTenders = createAsyncThunk('tender/getTenders', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/tender/getAllTenders`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE tender
export const deleteTender = createAsyncThunk('tender/deleteTender', async (tenderID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/tender/deleteTender/${tenderID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch tender list
    const response = await axios.get(`/api/tender/getAllTenders`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);

  }

});


// UPDATE tender
export const updateTender = createAsyncThunk('tender/updateTender', async (tenderDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const tenderID = tenderDetails.tenderID; // get tendersID from tenderDetails

    await axios.put(`/api/tender/updateTender/${tenderID}`, tenderDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return tender list
    const response = await axios.get(`/api/tender/getAllTenders`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// tenders slice
export const tenderSlice = createSlice({
  name: 'tender',
  initialState,
  reducers: {
    reset: (state) => {
      state.isLoading = false;
      state.isError = false;
      state.isSuccess = false;
      state.message = '';
    },
    postReset: (state) => {
      state.postLoading = false;
      state.postError = false;
      state.postSuccess = false;
      state.message = '';
    },
    updateReset: (state) => {
      state.updateLoading = false;
      state.updateError = false;
      state.updateSuccess = false;
      state.message = '';
    },
    deleteReset: (state) => {
      state.deleteLoading = false;
      state.deleteError = false;
      state.deleteSuccess = false;
      state.message = '';
    },
  },
  extraReducers: (builder) => {
    builder
      // GET
      .addCase(getTenders.pending, (state) => { state.isLoading = true; })
      .addCase(getTenders.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.tenders = action.payload;  })
      .addCase(getTenders.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.tenders = []; })

      // POST
      .addCase(postTender.pending, (state) => { state.postLoading = true; })
      .addCase(postTender.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'Tender posted successfully'; state.tenders = action.payload; })
      .addCase(postTender.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateTender.pending, (state) => { state.updateLoading = true; })
      .addCase(updateTender.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Tender updated successfully'; state.tenders = action.payload; })
      .addCase(updateTender.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteTender.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteTender.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'Tender deleted successfully'; state.tenders = action.payload; })
      .addCase(deleteTender.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = tenderSlice.actions;
export default tenderSlice.reducer;