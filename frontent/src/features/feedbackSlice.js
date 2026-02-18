import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { feedbacks: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST feedback
export const postFeedback = createAsyncThunk('feedback/postFeedback', async (feedbackDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/feedback/postFeedback`;
    const response = await axios.post(API_URL, feedbackDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all feedbacks
export const getFeedbacks = createAsyncThunk('feedback/getFeedbacks', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/feedback/getAllfeedbacks`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});



// GET user feedbacks
export const getUserFeedbacks = createAsyncThunk('feedback/getUserFeedbacks', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/feedback/getUserFeedbacks`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});



// DELETE feedback
export const deleteFeedback = createAsyncThunk('feedback/deleteFeedback', async (feedbackID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/feedback/deleteFeedback/${feedbackID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch feedback list
    const response = await axios.get(`/api/feedback/getAllfeedbacks`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// UPDATE feedback
export const updateFeedback = createAsyncThunk('feedback/updateFeedback', async (feedbackDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const feedbackID = feedbackDetails.get('feedbackID'); // get feedbackID from feedbackDetails (Formdata)

    await axios.put(`/api/feedback/updateFeedback/${feedbackID}`, feedbackDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return feedback list
    const response = await axios.get(`/api/feedback/getAllfeedbacks`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// UPDATE feedbackRead
export const updateFeedbackRead = createAsyncThunk('feedback/updateFeedbackRead', async (feedbackID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.post(`/api/feedback/updateFeedbackRead/${feedbackID}`, {}, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch user feedbacks
    const response = await axios.get(`/api/feedback/getUserFeedbacks`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);

  }

});


// feedbackPost slice
export const feedbackslice = createSlice({
  name: 'feedback',
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
      .addCase(getFeedbacks.pending, (state) => { state.isLoading = true; })
      .addCase(getFeedbacks.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.feedbacks = action.payload;  })
      .addCase(getFeedbacks.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.feedbacks = []; })

      // GET USER FEEDBACKS
      .addCase(getUserFeedbacks.pending, (state) => { state.isLoading = true; })
      .addCase(getUserFeedbacks.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.feedbacks = action.payload;  })
      .addCase(getUserFeedbacks.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.feedbacks = []; })

      // POST
      .addCase(postFeedback.pending, (state) => { state.postLoading = true; })
      .addCase(postFeedback.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'feedback posted successfully'; })
      .addCase(postFeedback.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateFeedback.pending, (state) => { state.updateLoading = true; })
      .addCase(updateFeedback.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'feedback updated successfully'; state.feedbacks = action.payload; })
      .addCase(updateFeedback.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // UPDATE FEEDBACK READ
      .addCase(updateFeedbackRead.pending, (state) => { state.updateLoading = true; })
      .addCase(updateFeedbackRead.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Feedback marked as read'; state.feedbacks = action.payload; })
      .addCase(updateFeedbackRead.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload; })

      // DELETE
      .addCase(deleteFeedback.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteFeedback.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'feedback deleted successfully'; state.feedbacks = action.payload; })
      .addCase(deleteFeedback.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = feedbackslice.actions;
export default feedbackslice.reducer;