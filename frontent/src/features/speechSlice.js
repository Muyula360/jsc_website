import axios from "axios";
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";

const initialState = {
  speeches: [],
  isLoading: false,

  postLoading: false,
  updateLoading: false,
  deleteLoading: false,

  isSuccess: false,
  postSuccess: false,
  updateSuccess: false,
  deleteSuccess: false,

  isError: false,
  postError: false,
  updateError: false,
  deleteError: false,

  message: "",
};

// GET ALL SPEECHES
export const getSpeeches = createAsyncThunk(
  "speech/getSpeeches",
  async (_, thunkAPI) => {
    try {
      const response = await axios.get("/api/speech/getAllSpeeches");
      // Validate response structure
      if (!Array.isArray(response.data)) {
        throw new Error("Invalid response format: expected an array");
      }
      return response.data;
    } catch (error) {
      return thunkAPI.rejectWithValue(
        error.response?.data?.message || error.message
      );
    }
  }
);

// POST SPEECH
export const postSpeech = createAsyncThunk(
  "speech/postSpeech",
  async (speechDetails, thunkAPI) => {
    try {
      const csrfToken = thunkAPI.getState()?.csrf?.csrfToken;
      if (!csrfToken) {
        throw new Error("CSRF token not available");
      }

      // Post the new speech
      await axios.post("/api/speech/postSpeech", speechDetails, {
        headers: { "X-CSRF-Token": csrfToken },
      });
      
      // Return fresh list
      const response = await axios.get("/api/speech/getAllSpeeches");
      return response.data;
    } catch (error) {
      return thunkAPI.rejectWithValue(
        error.response?.data?.message || error.message
      );
    }
  }
);

// UPDATE SPEECH
export const updateSpeech = createAsyncThunk(
  "speech/updateSpeech",
  async (speechDetails, thunkAPI) => {
    try {
      const csrfToken = thunkAPI.getState()?.csrf?.csrfToken;
      if (!csrfToken) {
        throw new Error("CSRF token not available");
      }

      // Extract ID - handle both FormData and regular object
      let speechID;
      if (speechDetails instanceof FormData) {
        speechID = speechDetails.get("announcementID");
      } else {
        speechID = speechDetails.announcementID;
      }

      if (!speechID) {
        throw new Error("Speech ID is required");
      }

      await axios.put(`/api/speech/updateSpeech/${speechID}`, speechDetails, {
        headers: { "X-CSRF-Token": csrfToken },
      });
      
      // Return fresh list
      const response = await axios.get("/api/speech/getAllSpeeches");
      return response.data;
    } catch (error) {
      return thunkAPI.rejectWithValue(
        error.response?.data?.message || error.message
      );
    }
  }
);

// DELETE SPEECH
export const deleteSpeech = createAsyncThunk(
  "speech/deleteSpeech",
  async (speechID, thunkAPI) => {
    try {
      const csrfToken = thunkAPI.getState()?.csrf?.csrfToken;
      if (!csrfToken) {
        throw new Error("CSRF token not available");
      }

      if (!speechID) {
        throw new Error("Speech ID is required");
      }

      await axios.delete(`/api/speech/deleteSpeech/${speechID}`, {
        headers: { "X-CSRF-Token": csrfToken },
      });
      
      // Return fresh list
      const response = await axios.get("/api/speech/getAllSpeeches");
      return response.data;
    } catch (error) {
      return thunkAPI.rejectWithValue(
        error.response?.data?.message || error.message
      );
    }
  }
);

const speechSlice = createSlice({
  name: "speech",
  initialState,
  reducers: {
    reset: (state) => {
      state.isLoading = false;
      state.isSuccess = false;
      state.isError = false;
      state.message = "";
    },
    postReset: (state) => {
      state.postLoading = false;
      state.postSuccess = false;
      state.postError = false;
      state.message = "";
    },
    updateReset: (state) => {
      state.updateLoading = false;
      state.updateSuccess = false;
      state.updateError = false;
      state.message = "";
    },
    deleteReset: (state) => {
      state.deleteLoading = false;
      state.deleteSuccess = false;
      state.deleteError = false;
      state.message = "";
    },
    // Add a manual update for optimistic updates
    updateSpeechLocally: (state, action) => {
      const index = state.speeches.findIndex(
        (s) => s.announcementID === action.payload.announcementID
      );
      if (index !== -1) {
        state.speeches[index] = { ...state.speeches[index], ...action.payload };
      }
    },
  },
  extraReducers: (builder) => {
    builder
      // GET
      .addCase(getSpeeches.pending, (state) => {
        state.isLoading = true;
        state.isError = false;
        state.message = "";
      })
      .addCase(getSpeeches.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isSuccess = true;
        // Ensure we have an array
        state.speeches = Array.isArray(action.payload) ? action.payload : [];
      })
      .addCase(getSpeeches.rejected, (state, action) => {
        state.isLoading = false;
        state.isError = true;
        state.message = action.payload || "Failed to fetch speeches";
        state.speeches = [];
      })
      
      // POST
      .addCase(postSpeech.pending, (state) => {
        state.postLoading = true;
        state.postError = false;
        state.message = "";
      })
      .addCase(postSpeech.fulfilled, (state, action) => {
        state.postLoading = false;
        state.postSuccess = true;
        state.speeches = Array.isArray(action.payload) ? action.payload : [];
      })
      .addCase(postSpeech.rejected, (state, action) => {
        state.postLoading = false;
        state.postError = true;
        state.message = action.payload || "Failed to post speech";
      })
      
      // UPDATE
      .addCase(updateSpeech.pending, (state) => {
        state.updateLoading = true;
        state.updateError = false;
        state.message = "";
      })
      .addCase(updateSpeech.fulfilled, (state, action) => {
        state.updateLoading = false;
        state.updateSuccess = true;
        state.speeches = Array.isArray(action.payload) ? action.payload : [];
      })
      .addCase(updateSpeech.rejected, (state, action) => {
        state.updateLoading = false;
        state.updateError = true;
        state.message = action.payload || "Failed to update speech";
      })
      
      // DELETE
      .addCase(deleteSpeech.pending, (state) => {
        state.deleteLoading = true;
        state.deleteError = false;
        state.message = "";
      })
      .addCase(deleteSpeech.fulfilled, (state, action) => {
        state.deleteLoading = false;
        state.deleteSuccess = true;
        state.speeches = Array.isArray(action.payload) ? action.payload : [];
      })
      .addCase(deleteSpeech.rejected, (state, action) => {
        state.deleteLoading = false;
        state.deleteError = true;
        state.message = action.payload || "Failed to delete speech";
      });
  },
});

export const {
  reset,
  postReset,
  updateReset,
  deleteReset,
  updateSpeechLocally,
} = speechSlice.actions;

// Selectors for better access
export const selectSpeeches = (state) => state.speech.speeches;
export const selectIsLoading = (state) => state.speech.isLoading;
export const selectDeleteLoading = (state) => state.speech.deleteLoading;
export const selectDeleteSuccess = (state) => state.speech.deleteSuccess;
export const selectDeleteError = (state) => state.speech.deleteError;
export const selectErrorMessage = (state) => state.speech.message;

export default speechSlice.reducer;