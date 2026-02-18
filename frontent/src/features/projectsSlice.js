import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";

const projectsList = [
     {
    id: 1,
    title: 'Construction of Integrated Justice Center (IJC)',
    region: 'Singida',
    location: 'Singidana Mjini, Tanzania',
    coverImage: 'singida_ijc.jpg',
    status: 'Onprogress',
    startDate: '20 July, 2023',
    progressPercentage: '15',
    updated: '07 March, 2025',
    link: 'https://jmap.judiciary.go.tz/plot-details/768d9fa9-e24e-4dfc-ad85-eb87fc8c87fe'
  },
  {
    id: 2,
    title: 'Construction of Integrated Justice Center (IJC)',
    region: 'Simiyu',
    location: 'Bariadi, Tanzania',
    coverImage: 'bariadi_ijc.jpg',
    status: 'Onprogress',
    startDate: '20 July, 2023',
    progressPercentage: '31',
    updated: '09 August, 2024',
    link: 'https://jmap.judiciary.go.tz/plot-details/3514ffcd-52ce-4904-b5b1-1349da2c800c'
  },
  {
    id: 3,
    title: 'Construction of Integrated Justice Center (IJC)',
    region: 'Geita',
    location: 'Geita Mjini, Tanzania',
    coverImage: 'geita_ijc.jpeg',
    status: 'Onprogress',
    startDate: '20 July, 2023',
    progressPercentage: '47',
    updated: '02 August, 2024',
    link: 'https://jmap.judiciary.go.tz/plot-details/d7e5529e-85c5-45fd-8931-4fb9ad7ded16'
  },
    {
    id: 4,
    title: 'Construction of Integrated Justice Center (IJC)',
    region: 'Ruvuma',
    location: ' Songea CBD, Tanzania',
    coverImage: 'songea_ijc.jpg',
    status: 'Onprogress',
    startDate: '20 July, 2023',
    progressPercentage: '27',
    updated: '22 September, 2024',
    link: 'https://jmap.judiciary.go.tz/plot-details/622d0049-6c28-40c7-8a8e-80eaef1d6797'
  },
    {
    id: 5,
    title: 'Construction of Integrated Justice Center (IJC)',
    region: 'Lindi',
    location: ' Lindi CBD, Tanzania',
    coverImage: 'lindi_ijc.jpg',
    status: 'Onprogress',
    startDate: '20 July, 2023',
    progressPercentage:'3',
    updated: '09 August, 2024',
    link: 'https://jmap.judiciary.go.tz/plot-details/7dbdc910-940c-4760-9318-18775dc76eeb'
  }
];



// Initial state
const initialState = { projects: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST project
export const postProject = createAsyncThunk('projects/postProject', async (projectDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;


});


// GET all projects --> when website loads (dispatch getProjects ) this function is invoked and send get request to the '/jmap' endpoint using axios
export const getProjects = createAsyncThunk('projects/getProjects', async (_, thunkAPI) => {

    try{
        // const API_URL = `/jmap`;

        // const response = await axios.get(API_URL, { headers:{'x-api-key': HRMIS_APIKEY}, });

        // return response.data;

        return projectsList;
                     
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


// DELETE project
export const deleteProject = createAsyncThunk('projects/deleteProject', async (projectID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;


});


// UPDATE project
export const updateProject = createAsyncThunk('projects/updateProject', async (projectDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;


});


// projects slice
export const projectsSlice = createSlice({
  name: 'projects',
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
      .addCase(getProjects.pending, (state) => { state.isLoading = true; })
      .addCase(getProjects.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.projects = action.payload;  })
      .addCase(getProjects.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.projects = []; })

      // POST
      .addCase(postProject.pending, (state) => { state.postLoading = true; })
      .addCase(postProject.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'Project posted successfully'; state.projects = action.payload; })
      .addCase(postProject.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateProject.pending, (state) => { state.updateLoading = true; })
      .addCase(updateProject.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Project updated successfully'; state.projects = action.payload; })
      .addCase(updateProject.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteProject.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteProject.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'Project deleted successfully'; state.projects = action.payload; })
      .addCase(deleteProject.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = projectsSlice.actions;
export default projectsSlice.reducer;
