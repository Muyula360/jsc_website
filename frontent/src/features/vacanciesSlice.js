import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";



// Initial state
const initialState = { vacancies: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST vacancy
export const postVacancy = createAsyncThunk('vacancy/postVacancy', async (vacancyDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const API_URL = `/api/vacancy/postVacancy`;
    await axios.post(API_URL, vacancyDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return vacancies list
    const response = await axios.get(`/api/vacancy/getAllVacancies`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// GET all vacancies
export const getVacancies = createAsyncThunk('vacancy/getVacancies', async (_, thunkAPI) => {

  try {

    const response = await axios.get(`/api/vacancy/getAllVacancies`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }
  
});


// DELETE vacancy
export const deleteVacancy = createAsyncThunk('vacancy/deleteVacancy', async (vacancyID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    await axios.delete(`/api/vacancy/deleteVacancy/${vacancyID}`, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Fetch vacancies list
    const response = await axios.get(`/api/vacancy/getAllVacancies`);
    return response.data;

  } catch (error) {

    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);

  }

});


// UPDATE vacancy
export const updateVacancy = createAsyncThunk('vacancy/updateVacancy', async (vacancyDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;

  try {

    const vacancyID = vacancyDetails.vacancyID; // get vacancyID from vacancyDetails

    await axios.put(`/api/vacancy/updateVacancy/${vacancyID}`, vacancyDetails, { headers: { 'X-CSRF-Token': csrfToken }, withCredentials: false, });

    // Return vacancies list
    const response = await axios.get(`/api/vacancy/getAllVacancies`);
    return response.data;

  } catch (error) {
    const errorMessage = (error.response?.data?.message) || error.message || error.toString();
    return thunkAPI.rejectWithValue(errorMessage);
  }

});


// vacancies slice
export const vacancySlice = createSlice({
  name: 'vacancy',
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
      .addCase(getVacancies.pending, (state) => { state.isLoading = true; })
      .addCase(getVacancies.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.vacancies = action.payload;  })
      .addCase(getVacancies.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.vacancies = []; })

      // POST
      .addCase(postVacancy.pending, (state) => { state.postLoading = true; })
      .addCase(postVacancy.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'Announcement posted successfully'; state.vacancies = action.payload; })
      .addCase(postVacancy.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateVacancy.pending, (state) => { state.updateLoading = true; })
      .addCase(updateVacancy.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Announcement updated successfully'; state.vacancies = action.payload; })
      .addCase(updateVacancy.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteVacancy.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteVacancy.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'Announcement deleted successfully'; state.vacancies = action.payload; })
      .addCase(deleteVacancy.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = vacancySlice.actions;
export default vacancySlice.reducer;