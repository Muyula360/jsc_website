import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { galleries: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST gallery
export const postAlbum = createAsyncThunk('gallery/postAlbum', async (albumDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/gallery/postAlbum`;
    await axios.post(API_URL, albumDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return gallery album list
    const response = await axios.get(`/api/gallery/getAlbums`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all gallery Albums
export const getAlbums = createAsyncThunk('gallery/getAlbums', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/gallery/getAlbums`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE gallery Album
export const deleteAlbum = createAsyncThunk('gallery/deleteAlbum', async (galleryID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/gallery/deleteAlbum/${galleryID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch gallery albums
    const response = await axios.get(`/api/gallery/getAlbums`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);

  }

});


// UPDATE gallery Album
export const updateAlbum = createAsyncThunk('gallery/updateAlbum', async (albumDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const galleryID = albumDetails.get('galleryID'); // get galleriesID from albumDetails (Formdata)

    await axios.put(`/api/gallery/updateAlbum/${galleryID}`, albumDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return gallery albums
    const response = await axios.get(`/api/gallery/getAlbums`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// galleries slice
export const gallerySlice = createSlice({
  name: 'gallery',
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
      .addCase(getAlbums.pending, (state) => { state.isLoading = true; })
      .addCase(getAlbums.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.galleries = action.payload;  })
      .addCase(getAlbums.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.galleries = []; })

      // POST
      .addCase(postAlbum.pending, (state) => { state.postLoading = true; })
      .addCase(postAlbum.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'Publication posted successfully'; state.galleries = action.payload; })
      .addCase(postAlbum.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateAlbum.pending, (state) => { state.updateLoading = true; })
      .addCase(updateAlbum.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Publication updated successfully'; state.galleries = action.payload; })
      .addCase(updateAlbum.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteAlbum.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteAlbum.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'Publication deleted successfully'; state.galleries = action.payload; })
      .addCase(deleteAlbum.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = gallerySlice.actions;
export default gallerySlice.reducer;