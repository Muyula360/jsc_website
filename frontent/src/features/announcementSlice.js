import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { announcements: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST announcement
export const postAnnouncement = createAsyncThunk('announcement/postAnnouncement', async (announcementDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/announcement/postAnnouncement`;
    await axios.post(API_URL, announcementDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return announcement list
    const response = await axios.get(`/api/announcement/getAllAnnouncements`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all announcements
export const getAnnouncements = createAsyncThunk('announcement/getAnnouncements', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/announcement/getAllAnnouncements`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE announcement
export const deleteAnnouncement = createAsyncThunk('announcement/deleteAnnouncement', async (announcementID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/announcement/deleteAnnouncement/${announcementID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch announcement list
    const response = await axios.get(`/api/announcement/getAllAnnouncements`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);

  }

});


// UPDATE announcement
export const updateAnnouncement = createAsyncThunk('announcement/updateAnnouncement', async (announcementDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const announcementID = announcementDetails.get('announcementID'); // get announcementsID from announcementDetails (Formdata)

    await axios.put(`/api/announcement/updateAnnouncement/${announcementID}`, announcementDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return announcement list
    const response = await axios.get(`/api/announcement/getAllAnnouncements`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// announcements slice
export const announcementSlice = createSlice({
  name: 'announcement',
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
      .addCase(getAnnouncements.pending, (state) => { state.isLoading = true; })
      .addCase(getAnnouncements.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.announcements = action.payload;  })
      .addCase(getAnnouncements.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.announcements = []; })

      // POST
      .addCase(postAnnouncement.pending, (state) => { state.postLoading = true; })
      .addCase(postAnnouncement.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'Announcement posted successfully'; state.announcements = action.payload; })
      .addCase(postAnnouncement.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateAnnouncement.pending, (state) => { state.updateLoading = true; })
      .addCase(updateAnnouncement.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Announcement updated successfully'; state.announcements = action.payload; })
      .addCase(updateAnnouncement.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteAnnouncement.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteAnnouncement.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'Announcement deleted successfully'; state.announcements = action.payload; })
      .addCase(deleteAnnouncement.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = announcementSlice.actions;
export default announcementSlice.reducer;