import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { users: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST User
export const postUser = createAsyncThunk('User/createAccount', async (UserDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/user/createAccount`;
    await axios.post(API_URL, UserDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return Users list
    const response = await axios.get(`/api/user/getUsersList`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all users
export const getUsers = createAsyncThunk('User/getUsers', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/user/getUsersList`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE User
export const deleteUser = createAsyncThunk('User/deleteUser', async (userID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/user/deleteUser/${userID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch User list
    const response = await axios.get(`/api/user/getUsersList`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);

  }

});


// UPDATE User
export const updateUser = createAsyncThunk('User/updateUser', async (userDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const userID = userDetails.get('userID'); // get userID from userDetails (Formdata)

    await axios.put(`/api/user/updateUser/${userID}`, userDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return User list
    const response = await axios.get(`/api/user/getUsersList`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// users slice
export const userSlice = createSlice({
  name: 'user',
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
      .addCase(getUsers.pending, (state) => { state.isLoading = true; })
      .addCase(getUsers.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.users = action.payload;  })
      .addCase(getUsers.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.users = []; })

      // POST
      .addCase(postUser.pending, (state) => { state.postLoading = true; })
      .addCase(postUser.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'User posted successfully'; state.users = action.payload; })
      .addCase(postUser.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateUser.pending, (state) => { state.updateLoading = true; })
      .addCase(updateUser.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'User updated successfully'; state.users = action.payload; })
      .addCase(updateUser.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteUser.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteUser.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'User deleted successfully'; state.users = action.payload; })
      .addCase(deleteUser.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = userSlice.actions;
export default userSlice.reducer;