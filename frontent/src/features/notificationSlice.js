import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { notifications: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST notification
export const postNotification = createAsyncThunk('notification/postNotification', async (notificationDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {



  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all notifications
export const getNotifications = createAsyncThunk('notification/getNotifications', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/notification/getAllnotifications`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});



// GET user notifications
export const getUserNotifications = createAsyncThunk('notification/getUserNotifications', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/notification/getUserNotifications`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE notification
export const deleteNotification = createAsyncThunk('notification/deleteNotification', async (notificationID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {


  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// UPDATE Notification read,
export const updateRead = createAsyncThunk('notification/updateRead', async ({ notificationID, showOnCarouselDisplay }, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {



  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});



// UPDATE notification
export const updateNotification = createAsyncThunk('notification/updateNotification', async (notificationDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {



  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});



// UPDATE notificationRead
export const updateNotificationRead = createAsyncThunk('notification/updateNotificationRead', async (notificationID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.post(`/api/notification/updateNotificationRead/${notificationID}`, {}, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch user notifications
    const response = await axios.get(`/api/notification/getUserNotifications`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);

  }

});



// notificationPost slice
export const notificationslice = createSlice({
  name: 'notification',
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
      // GET ALL NOTIFICATIONS
      .addCase(getNotifications.pending, (state) => { state.isLoading = true; })
      .addCase(getNotifications.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.notifications = action.payload;  })
      .addCase(getNotifications.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.notifications = []; })

      // GET USER NOTIFICATIONS
      .addCase(getUserNotifications.pending, (state) => { state.isLoading = true; })
      .addCase(getUserNotifications.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.notifications = action.payload;  })
      .addCase(getUserNotifications.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.notifications = []; })

      // POST
      .addCase(postNotification.pending, (state) => { state.postLoading = true; })
      .addCase(postNotification.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'notification posted successfully'; state.notifications = action.payload; })
      .addCase(postNotification.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE NOTIFICATION
      .addCase(updateNotification.pending, (state) => { state.updateLoading = true; })
      .addCase(updateNotification.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'notification updated successfully'; state.notifications = action.payload; })
      .addCase(updateNotification.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // UPDATE NOTIFICATION READ
      .addCase(updateNotificationRead.pending, (state) => { state.updateLoading = true; })
      .addCase(updateNotificationRead.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Notification marked as read'; state.notifications = action.payload; })
      .addCase(updateNotificationRead.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload; })

      // DELETE
      .addCase(deleteNotification.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteNotification.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'notification deleted successfully'; state.notifications = action.payload; })
      .addCase(deleteNotification.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = notificationslice.actions;
export default notificationslice.reducer;