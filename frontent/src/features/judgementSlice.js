import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';

// Sample static data (you can later fetch from TanzLII API or backend)
const judgmentList = [
  {
    id: 1,
    type: 'Civil Appeal',
    title: 'Julius Malago vs Petro Afrika and Salum Shaban (Civil Appeal No. 9173 of 2025) [2025] TZHC 3925 (17 July 2025)',
    summary: 'The trial court erred in expunging admitted exhibits, rendering its judgment null and ordering a fresh hearing.',
    court: 'Court of Appeal of Tanzania',
    date: '17 July, 2025',
    link: 'https://tanzlii.org/judgments/TZHC/3925'
  },
  {
    id: 2,
    type: 'Misc. Criminal Application',
    title: 'DPP vs Hussein Juma Kadari & 6 others (Misc. Criminal Application No. 15160 of 2025) [2025] TZHC 3924 (17 July 2025)',
    summary: 'The High Court issued a ruling on a miscellaneous criminal application involving pending charges.',
    court: 'High Court of Tanzania',
    date: '17 July, 2025',
    link: 'https://tanzlii.org/judgments/TZHC/3924'
  },
  {
    id: 3,
    type: 'Civil Application',
    title: 'Fatuma Shabani vs Laurent Makundya & Baraka Mase (Civil Application No. 23705 of 2024) [2025] TZHC 3930 (16 July 2025)',
    summary: 'Court granted extension of time to appeal due to conflicting district court rulings causing legal uncertainty.',
    court: 'High Court of Tanzania',
    date: '16 July, 2025',
    link: 'https://tanzlii.org/judgments/TZHC/3930'
  }
];

//initial state 
const initialState = {judgments: [], isLoading: false, isSuccess: false, isError: false, message: ''};

// GET all judgement --> when website loads (dispatch getProjects ) this function is invoked and send get request to the actual API/endpoint using axios
export const getJudgments = createAsyncThunk('judgments/getJudgments', async (_, thunkAPI) => {
  try {
    // Replace this with an actual API call
    return judgmentList;
  } catch (error) {
    const message = (error.response?.data?.message) || error.message || 'Error fetching judgments';
    return thunkAPI.rejectWithValue(message);
  }
});


const judgmentSlice = createSlice({
  name: 'judgments',
  initialState,
  reducers: {
    reset: (state) => {
      state.isLoading = false;
      state.isError = false;
      state.isSuccess = false;
      state.message = '';
    }
  },
  extraReducers: (builder) => {
    builder
      .addCase(getJudgments.pending, (state) => {
        state.isLoading = true;
      })
      .addCase(getJudgments.fulfilled, (state, action) => {
        state.isLoading = false;
        state.isSuccess = true;
        state.judgments = action.payload;
      })
      .addCase(getJudgments.rejected, (state, action) => {
        state.isLoading = false;
        state.isError = true;
        state.message = action.payload;
        state.judgments = [];
      });
  }
});

export const { reset } = judgmentSlice.actions;
export default judgmentSlice.reducer;
