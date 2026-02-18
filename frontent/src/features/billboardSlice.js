import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { billboards: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST billboard
export const postBillboard = createAsyncThunk('billboard/postBillboard', async (billboardDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/billboard/postBillboard`;
    await axios.post(API_URL, billboardDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return billboard list
    const response = await axios.get(`/api/billboard/getAllBillboards`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all billboard posts
export const getBillboardPosts = createAsyncThunk('billboard/getBillboardPosts', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/billboard/getAllBillboards`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE billboard
export const deleteBillboardPost = createAsyncThunk('billboard/deleteBillboardPost', async (billboardID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/billboard/deleteBillboard/${billboardID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch billboard list
    const response = await axios.get(`/api/billboard/getAllBillboards`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// UPDATE ShowOnCarousel,
export const updateShowOnCarousel = createAsyncThunk('billboard/updateShowOnCarousel', async ({ billboardID, showOnCarouselDisplay }, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const response = await axios.put(`/api/billboard/toggleDisplay/${billboardID}`, { showOnCarouselDisplay: showOnCarouselDisplay }, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});



// UPDATE billboard
export const updateBillboardPost = createAsyncThunk('billboard/updateBillboardPost', async (billboardDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const billboardID = billboardDetails.get('billboardID'); // get billboardID from billboardDetails (Formdata)

    await axios.put(`/api/billboard/updateBillboard/${billboardID}`, billboardDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return billboard list
    const response = await axios.get(`/api/billboard/getAllBillboards`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// billboardPost slice
export const billboardSlice = createSlice({
  name: 'billboard',
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
      .addCase(getBillboardPosts.pending, (state) => { state.isLoading = true; })
      .addCase(getBillboardPosts.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.billboards = action.payload;  })
      .addCase(getBillboardPosts.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.billboards = []; })

      // POST
      .addCase(postBillboard.pending, (state) => { state.postLoading = true; })
      .addCase(postBillboard.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'Billboard posted successfully'; state.billboards = action.payload; })
      .addCase(postBillboard.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateBillboardPost.pending, (state) => { state.updateLoading = true; })
      .addCase(updateBillboardPost.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Billboard updated successfully'; state.billboards = action.payload; })
      .addCase(updateBillboardPost.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteBillboardPost.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteBillboardPost.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'Billboard deleted successfully'; state.billboards = action.payload; })
      .addCase(deleteBillboardPost.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = billboardSlice.actions;
export default billboardSlice.reducer;