import axios from "axios";
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";

// Initial state
const initialState = {
  newsletters: [],
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

  message: ""
};

// POST newsletter
export const postNewsletter = createAsyncThunk(
  "newsletter/postNewsletter",
  async (newsletterDetails, thunkAPI) => {
    const csrfToken = thunkAPI.getState().csrf.csrfToken;

    try {
      const API_URL = "/api/newsletter/postNewsletter";

      await axios.post(API_URL, newsletterDetails, {
        headers: { "X-CSRF-Token": csrfToken },
        withCredentials: false
      });

      // Return newsletter list
      const response = await axios.get(
        "/api/newsletter/getAllNewsletters"
      );
      return response.data;
    } catch (error) {
      const errorMessage =
        error.response?.data?.message ||
        error.message ||
        error.toString();
      return thunkAPI.rejectWithValue(errorMessage);
    }
  }
);

// GET all newsletters
export const getNewsletters = createAsyncThunk(
  "newsletter/getNewsletters",
  async (_, thunkAPI) => {
    try {
      const response = await axios.get(
        "/api/newsletter/getAllNewsletters"
      );
      return response.data;
    } catch (error) {
      const errorMessage =
        error.response?.data?.message ||
        error.message ||
        error.toString();
      return thunkAPI.rejectWithValue(errorMessage);
    }
  }
);

// DELETE newsletter
export const deleteNewsletter = createAsyncThunk(
  "newsletter/deleteNewsletter",
  async (newsletterID, thunkAPI) => {
    const csrfToken = thunkAPI.getState().csrf.csrfToken;

    try {
      await axios.delete(
        `/api/newsletter/deleteNewsletter/${newsletterID}`,
        {
          headers: { "X-CSRF-Token": csrfToken },
          withCredentials: false
        }
      );

      // Fetch newsletter list
      const response = await axios.get(
        "/api/newsletter/getAllNewsletters"
      );
      return response.data;
    } catch (error) {
      const errorMessage =
        error.response?.data?.message ||
        error.message ||
        error.toString();
      return thunkAPI.rejectWithValue(errorMessage);
    }
  }
);

// UPDATE newsletter
export const updateNewsletter = createAsyncThunk(
  "newsletter/updateNewsletter",
  async (newsletterDetails, thunkAPI) => {
    const csrfToken = thunkAPI.getState().csrf.csrfToken;

    try {
      // get newsletterID from FormData
      const newsletterID = newsletterDetails.get("newsletterID");

      await axios.put(
        `/api/newsletter/updateNewsletter/${newsletterID}`,
        newsletterDetails,
        {
          headers: { "X-CSRF-Token": csrfToken },
          withCredentials: false
        }
      );

      // Return newsletter list
      const response = await axios.get(
        "/api/newsletter/getAllNewsletters"
      );
      return response.data;
    } catch (error) {
      const errorMessage =
        error.response?.data?.message ||
        error.message ||
        error.toString();
      return thunkAPI.rejectWithValue(errorMessage);
    }
  }
);

// Newsletter slice
export const newsletterSlice = createSlice({
  name: "newsletter",
  initialState,
  reducers: {
    reset: (state) => {
      state.isLoading = false;
      state.isError = false;
      state.isSuccess = false;
      state.message = "";
    },
    postReset: (state) => {
      state.postLoading = false;
      state.postError = false;
      state.postSuccess = false;
      state.message = "";
    },
    updateReset: (state) => {
      state.updateLoading = false;
      state.updateError = false;
      state.updateSuccess = false;
      state.message = "";
    },
    deleteReset: (state) => {
      state.deleteLoading = false;
      state.deleteError = false;
      state.deleteSuccess = false;
      state.message = "";
    }
  },
  extraReducers: (builder) => {
    builder
      // GET
      .addCase(getNewsletters.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(getNewsletters.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isSuccess = true;
        state.newsletters = action.payload;
      })
      .addCase(getNewsletters.rejected, (state, action) => {
        state.isLoading = false;
        state.isError = true;
        state.message = action.payload;
        state.newsletters = [];
      })

      // POST
      .addCase(postNewsletter.pending, (state) => {
        state.postLoading = true;
      })
      .addCase(postNewsletter.fulfilled, (state, action) => {
        state.postLoading = false;
        state.postSuccess = true;
        state.message = "Newsletter posted successfully";
        state.newsletters = action.payload;
      })
      .addCase(postNewsletter.rejected, (state, action) => {
        state.postLoading = false;
        state.postError = true;
        state.message = action.payload;
      })

      // UPDATE
      .addCase(updateNewsletter.pending, (state) => {
        state.updateLoading = true;
      })
      .addCase(updateNewsletter.fulfilled, (state, action) => {
        state.updateLoading = false;
        state.updateSuccess = true;
        state.message = "Newsletter updated successfully";
        state.newsletters = action.payload;
      })
      .addCase(updateNewsletter.rejected, (state, action) => {
        state.updateLoading = false;
        state.updateError = true;
        state.message = action.payload;
      })

      // DELETE
      .addCase(deleteNewsletter.pending, (state) => {
        state.deleteLoading = true;
      })
      .addCase(deleteNewsletter.fulfilled, (state, action) => {
        state.deleteLoading = false;
        state.deleteSuccess = true;
        state.message = "Newsletter deleted successfully";
        state.newsletters = action.payload;
      })
      .addCase(deleteNewsletter.rejected, (state, action) => {
        state.deleteLoading = false;
        state.deleteError = true;
        state.message = action.payload;
      });
  }
});

export const {
  reset,
  postReset,
  updateReset,
  deleteReset
} = newsletterSlice.actions;

export default newsletterSlice.reducer;
