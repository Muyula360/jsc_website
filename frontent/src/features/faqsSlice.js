import axios from "axios";
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";

const initialState = {
  faqs: [],
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

// GET ALL FAQs
export const getFAQs = createAsyncThunk(
  "faq/getFAQs",
  async (_, thunkAPI) => {
    try {
      const response = await axios.get("/api/faq/getAllFAQs");
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

// POST FAQ
export const postFAQ = createAsyncThunk(
  "faq/postFAQ",
  async (faqDetails, thunkAPI) => {
    try {
      const csrfToken = thunkAPI.getState()?.csrf?.csrfToken;
      if (!csrfToken) {
        throw new Error("CSRF token not available");
      }

      // Post the new FAQ
      await axios.post("/api/faq/postFAQ", faqDetails, {
        headers: { "X-CSRF-Token": csrfToken },
      });
      
      // Return fresh list
      const response = await axios.get("/api/faq/getAllFAQs");
      return response.data;
    } catch (error) {
      return thunkAPI.rejectWithValue(
        error.response?.data?.message || error.message
      );
    }
  }
);

// UPDATE FAQ
export const updateFAQ = createAsyncThunk(
  "faq/updateFAQ",
  async (faqDetails, thunkAPI) => {
    try {
      const csrfToken = thunkAPI.getState()?.csrf?.csrfToken;
      if (!csrfToken) {
        throw new Error("CSRF token not available");
      }

      // Extract ID - handle both FormData and regular object
      let faqsID;
      if (faqDetails instanceof FormData) {
        faqsID = faqDetails.get("faqsID");
      } else {
        faqsID = faqDetails.faqsID;
      }

      if (!faqsID) {
        throw new Error("FAQ ID is required");
      }

      await axios.put(`/api/faq/updateFAQ/${faqsID}`, faqDetails, {
        headers: { "X-CSRF-Token": csrfToken },
      });
      
      // Return fresh list
      const response = await axios.get("/api/faq/getAllFAQs");
      return response.data;
    } catch (error) {
      return thunkAPI.rejectWithValue(
        error.response?.data?.message || error.message
      );
    }
  }
);

// DELETE FAQ
export const deleteFAQ = createAsyncThunk(
  "faq/deleteFAQ",
  async (faqsID, thunkAPI) => {
    try {
      const csrfToken = thunkAPI.getState()?.csrf?.csrfToken;
      if (!csrfToken) {
        throw new Error("CSRF token not available");
      }

      if (!faqsID) {
        throw new Error("FAQ ID is required");
      }

      await axios.delete(`/api/faq/deleteFAQ/${faqsID}`, {
        headers: { "X-CSRF-Token": csrfToken },
      });
      
      // Return fresh list
      const response = await axios.get("/api/faq/getAllFAQs");
      return response.data;
    } catch (error) {
      return thunkAPI.rejectWithValue(
        error.response?.data?.message || error.message
      );
    }
  }
);

const faqSlice = createSlice({
  name: "faq",
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
    updateFAQLocally: (state, action) => {
      const index = state.faqs.findIndex(
        (f) => f.faqsID === action.payload.faqsID
      );
      if (index !== -1) {
        state.faqs[index] = { ...state.faqs[index], ...action.payload };
      }
    },
    // Add optimistic delete
    deleteFAQLocally: (state, action) => {
      state.faqs = state.faqs.filter(f => f.faqsID !== action.payload);
    },
    // Add optimistic add
    addFAQLocally: (state, action) => {
      state.faqs.unshift(action.payload);
    }
  },
  extraReducers: (builder) => {
    builder
      // GET
      .addCase(getFAQs.pending, (state) => {
        state.isLoading = true;
        state.isError = false;
        state.message = "";
      })
      .addCase(getFAQs.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isSuccess = true;
        // Ensure we have an array
        state.faqs = Array.isArray(action.payload) ? action.payload : [];
      })
      .addCase(getFAQs.rejected, (state, action) => {
        state.isLoading = false;
        state.isError = true;
        state.message = action.payload || "Failed to fetch FAQs";
        state.faqs = [];
      })
      
      // POST
      .addCase(postFAQ.pending, (state) => {
        state.postLoading = true;
        state.postError = false;
        state.message = "";
      })
      .addCase(postFAQ.fulfilled, (state, action) => {
        state.postLoading = false;
        state.postSuccess = true;
        state.faqs = Array.isArray(action.payload) ? action.payload : [];
      })
      .addCase(postFAQ.rejected, (state, action) => {
        state.postLoading = false;
        state.postError = true;
        state.message = action.payload || "Failed to post FAQ";
      })
      
      // UPDATE
      .addCase(updateFAQ.pending, (state) => {
        state.updateLoading = true;
        state.updateError = false;
        state.message = "";
      })
      .addCase(updateFAQ.fulfilled, (state, action) => {
        state.updateLoading = false;
        state.updateSuccess = true;
        state.faqs = Array.isArray(action.payload) ? action.payload : [];
      })
      .addCase(updateFAQ.rejected, (state, action) => {
        state.updateLoading = false;
        state.updateError = true;
        state.message = action.payload || "Failed to update FAQ";
      })
      
      // DELETE
      .addCase(deleteFAQ.pending, (state) => {
        state.deleteLoading = true;
        state.deleteError = false;
        state.message = "";
      })
      .addCase(deleteFAQ.fulfilled, (state, action) => {
        state.deleteLoading = false;
        state.deleteSuccess = true;
        state.faqs = Array.isArray(action.payload) ? action.payload : [];
      })
      .addCase(deleteFAQ.rejected, (state, action) => {
        state.deleteLoading = false;
        state.deleteError = true;
        state.message = action.payload || "Failed to delete FAQ";
      });
  },
});

export const {
  reset,
  postReset,
  updateReset,
  deleteReset,
  updateFAQLocally,
  deleteFAQLocally,
  addFAQLocally
} = faqSlice.actions;

// Selectors for better access
export const selectFAQs = (state) => state.faq.faqs;
export const selectIsLoading = (state) => state.faq.isLoading;
export const selectPostLoading = (state) => state.faq.postLoading;
export const selectUpdateLoading = (state) => state.faq.updateLoading;
export const selectDeleteLoading = (state) => state.faq.deleteLoading;
export const selectPostSuccess = (state) => state.faq.postSuccess;
export const selectUpdateSuccess = (state) => state.faq.updateSuccess;
export const selectDeleteSuccess = (state) => state.faq.deleteSuccess;
export const selectPostError = (state) => state.faq.postError;
export const selectUpdateError = (state) => state.faq.updateError;
export const selectDeleteError = (state) => state.faq.deleteError;
export const selectErrorMessage = (state) => state.faq.message;

export default faqSlice.reducer;