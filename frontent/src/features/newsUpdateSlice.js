import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { newsupdates: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST news
export const postNews = createAsyncThunk('newsupdate/postNews', async (newsDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/newsupdates/postNewsupdates`;
    await axios.post(API_URL, newsDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return news list
    const response = await axios.get(`/api/newsupdates/getAllNews`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all news
export const getNewsupdates = createAsyncThunk('newsupdate/getNewsupdates', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/newsupdates/getAllNews`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE news
export const deleteNews = createAsyncThunk('newsupdate/deleteNews', async (newsID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/newsupdates/deleteNews/${newsID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch news list
    const response = await axios.get(`/api/newsupdates/getAllNews`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// UPDATE news
export const updateNews = createAsyncThunk('newsupdate/updateNews', async (newsDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const newsID = newsDetails.get('newsupdatesID'); // get newsupdatesID from newsDetails (Formdata)

    await axios.put(`/api/newsupdates/updateNews/${newsID}`, newsDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return news list
    const response = await axios.get(`/api/newsupdates/getAllNews`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// newsupdates slice
export const newsupdatesSlice = createSlice({
  name: 'newsupdate',
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
      .addCase(getNewsupdates.pending, (state) => { state.isLoading = true; })
      .addCase(getNewsupdates.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.newsupdates = action.payload;  })
      .addCase(getNewsupdates.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.newsupdates = []; })

      // POST
      .addCase(postNews.pending, (state) => { state.postLoading = true; })
      .addCase(postNews.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'News posted successfully'; state.newsupdates = action.payload; })
      .addCase(postNews.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateNews.pending, (state) => { state.updateLoading = true; })
      .addCase(updateNews.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'News updated successfully'; state.newsupdates = action.payload; })
      .addCase(updateNews.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteNews.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteNews.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'News deleted successfully'; state.newsupdates = action.payload; })
      .addCase(deleteNews.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = newsupdatesSlice.actions;
export default newsupdatesSlice.reducer;