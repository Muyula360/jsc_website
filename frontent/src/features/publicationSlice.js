import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { publications: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST publication
export const postPublication = createAsyncThunk('publication/postPublication', async (publicationDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/publication/postPublicContent`;
    await axios.post(API_URL, publicationDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return publication list
    const response = await axios.get(`/api/publication/getAllPublicContents`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all publications
export const getPublications = createAsyncThunk('publication/getPublications', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/publication/getAllPublicContents`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE publication
export const deletePublication = createAsyncThunk('publication/deletePublication', async (publicationID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/publication/deletePublicContent/${publicationID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch publication list
    const response = await axios.get(`/api/publication/getAllPublicContents`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);

  }

});


// UPDATE publication
export const updatePublication = createAsyncThunk('publication/updatePublication', async (publicationDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const publicationID = publicationDetails.get('publicationID'); // get publicationsID from publicationDetails (Formdata)

    await axios.put(`/api/publication/updatePublicContent/${publicationID}`, publicationDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return publication list
    const response = await axios.get(`/api/publication/getAllPublicContents`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// publications slice
export const publicationSlice = createSlice({
  name: 'publication',
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
      .addCase(getPublications.pending, (state) => { state.isLoading = true; })
      .addCase(getPublications.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.publications = action.payload;  })
      .addCase(getPublications.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.publications = []; })

      // POST
      .addCase(postPublication.pending, (state) => { state.postLoading = true; })
      .addCase(postPublication.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'Publication posted successfully'; state.publications = action.payload; })
      .addCase(postPublication.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updatePublication.pending, (state) => { state.updateLoading = true; })
      .addCase(updatePublication.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Publication updated successfully'; state.publications = action.payload; })
      .addCase(updatePublication.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deletePublication.pending, (state) => { state.deleteLoading = true; })
      .addCase(deletePublication.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'Publication deleted successfully'; state.publications = action.payload; })
      .addCase(deletePublication.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = publicationSlice.actions;
export default publicationSlice.reducer;