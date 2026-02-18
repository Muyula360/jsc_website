import axios from 'axios';
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";

const judgesList = [
{
    "prefix": "Hon. Justice",
    "name": "Mustapher Siyani",
    "coverPhoto": "website-repository/leadersprofilepictures/2025/2/leaderProfilePic-1749794166785-192093541.jpg",
    "profession": "Judge",
    "designation": "Principal Judge of the High Court",
    "firstEmployment": "1999-01-10",
    "category": "High Court",
    "bio": "Justice Siyani currently serves as the Principal Judge, overseeing the administration of High Court matters across Tanzania."
},
{
    "prefix": "Hon. Justice",
    "name": "Prof. Ibrahim Juma",
    "coverPhoto": "website-repository/leadersprofilepictures/2025/1/leaderProfilePic-1749804574868-899077159.jpg",
    "profession": "Judge",
    "designation": "Chief Justice of Tanzania",
    "firstEmployment": "1989-06-15",
    "category": "Court of Appeal",
    "bio": "Prof. Juma is the Chief Justice and the head of the Judiciary of Tanzania. He is also a renowned legal scholar and reform advocate."
},
{
    "prefix": "Hon. Lady Justice",
    "name": "Zainab Mruke",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Justice of Appeal",
    "firstEmployment": "2002-03-22",
    "category": "Court of Appeal",
    "bio": "Justice Mruke has served in both High Court and Court of Appeal and is known for her legal acumen in civil and administrative cases."
},
{
    "prefix": "Hon. Justice",
    "name": "Augustino Lyimo",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2004-11-03",
    "category": "High Court",
    "bio": "Justice Lyimo specializes in criminal law and has served in the High Court's Criminal Division for over a decade."
},
{
    "prefix": "Hon. Lady Justice",
    "name": "Stella Mugasha",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Justice of Appeal",
    "firstEmployment": "1997-07-01",
    "category": "Court of Appeal",
    "bio": "Justice Mugasha is widely respected for her expertise in corporate and commercial litigation."
},
{
    "prefix": "Hon. Justice",
    "name": "Benhajj Masoud",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2006-09-25",
    "category": "High Court",
    "bio": "Known for his impartiality and discipline, Justice Masoud serves in the Land Division of the High Court."
},
{
    "prefix": "Hon. Justice",
    "name": "Rehema Mkuye",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2009-01-20",
    "category": "High Court",
    "bio": "Justice Mkuye has contributed significantly to the Family and Juvenile Court system in Tanzania."
},
{
    "prefix": "Hon. Justice",
    "name": "Richard Mziray",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2001-05-18",
    "category": "High Court",
    "bio": "Justice Mziray is a long-serving High Court judge who has presided over high-profile constitutional cases."
},
{
    "prefix": "Hon. Justice",
    "name": "Jacqueline Komanya",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Justice of Appeal",
    "firstEmployment": "2000-03-10",
    "category": "Court of Appeal",
    "bio": "Justice Komanya is celebrated for her service in both appellate and electoral courts."
},
{
    "prefix": "Hon. Justice",
    "name": "Sam Rumanyika",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2003-08-14",
    "category": "High Court",
    "bio": "Justice Rumanyika is known for straightforward decisions and writing in plain legal language."
},
{
    "prefix": "Hon. Justice",
    "name": "Sylvester Kaijage",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Justice of Appeal",
    "firstEmployment": "1998-02-02",
    "category": "Court of Appeal",
    "bio": "Justice Kaijage has served in various election tribunals and has extensive experience in human rights law."
},
{
    "prefix": "Hon. Lady Justice",
    "name": "Tulia Msonde",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2010-06-29",
    "category": "Former",
    "bio": "Justice Msonde has a passion for environmental justice and public interest litigation."
},
{
    "prefix": "Hon. Justice",
    "name": "Francis Mutungi",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Registrar of the High Court",
    "firstEmployment": "2007-10-01",
    "category": "High Court",
    "bio": "Besides judicial duties, Justice Mutungi also supervises case flow and judicial performance in the registry."
},
{
    "prefix": "Hon. Justice",
    "name": "Barky Joseph",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Deputy Registrar, Court of Appeal",
    "firstEmployment": "2005-12-12",
    "category": "Former",
    "bio": "Justice Joseph provides administrative leadership and supports appellate court operations."
},
{
    "prefix": "Hon. Lady Justice",
    "name": "Fatuma Mkwawa",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2002-09-09",
    "category": "High Court",
    "bio": "Justice Mkwawa serves in the Labour Division and has experience in dispute mediation."
},
{
    "prefix": "Hon. Justice",
    "name": "Edson Mkasimongwa",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2006-04-01",
    "category": "Former",
    "bio": "He is recognized for his role in digitizing records and introducing electronic filing in several courts."
},
{
    "prefix": "Hon. Justice",
    "name": "Issa Maige",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Justice of Appeal",
    "firstEmployment": "1996-11-21",
    "category": "Former",
    "bio": "Justice Maige has an extensive background in taxation and public finance law."
},
{
    "prefix": "Hon. Justice",
    "name": "Angelina Mashale",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2011-01-10",
    "category": "Former",
    "bio": "Justice Mashale has a strong academic background and advocates for judicial education."
},
{
    "prefix": "Hon. Justice",
    "name": "Stephen Magesa",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Registrar, Court of Appeal",
    "firstEmployment": "2000-06-06",
    "category": "Former",
    "bio": "In addition to case management, he promotes access to justice in remote areas of the country."
},
{
    "prefix": "Hon. Lady Justice",
    "name": "Naomi Juma",
    "coverPhoto": "",
    "profession": "Judge",
    "designation": "Judge of the High Court",
    "firstEmployment": "2003-07-07",
    "category": "High Court",
    "bio": "Justice Juma is well-known for championing women's rights through landmark court rulings."
}
];



// Initial state
const initialState = { judges: [], isLoading:false, postLoading:false, updateLoading:false, deleteLoading:false, isSuccess:false, postSuccess:false, updateSuccess:false, deleteSuccess:false, isError:false, postError:false, updateError:false, deleteError:false, message:'' }


// POST judge
export const postJudge = createAsyncThunk('judges/postJudge', async (judgeDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;


});


// GET all judges --> when website loads (dispatch getJudges ) this function is invoked and send get request to the '/jahrm-connect/api/v1/bio/profile_bio' endpoint using axios
export const getJudges = createAsyncThunk('judges/getJudges', async (_, thunkAPI) => {

    try{
        // const API_URL = `/jahrm-connect/api/v1/bio/profile_bio`;

        // const response = await axios.get(API_URL, { headers:{'x-api-key': HRMIS_APIKEY}, });

        // return response.data;

        return judgesList;
                     
    }catch(error){

        const errorMessage = (error.response && error.response.data && error.response.data.message) || error.message || error.toString()
        return thunkAPI.rejectWithValue(errorMessage);
    }
});


// DELETE judge
export const deleteJudge = createAsyncThunk('judges/deleteJudge', async (judgeID, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;


});


// UPDATE judge
export const updateJudge = createAsyncThunk('judges/updateJudge', async (judgeDetails, thunkAPI) => {

  const csrfToken = thunkAPI.getState().csrf.csrfToken;


});


// judges slice
export const judgesSlice = createSlice({
  name: 'judges',
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
      .addCase(getJudges.pending, (state) => { state.isLoading = true; })
      .addCase(getJudges.fulfilled, (state, action) => { state.isLoading = false; state.isSuccess = true; state.judges = action.payload;  })
      .addCase(getJudges.rejected, (state, action) => { state.isLoading = false; state.isError = true; state.message = action.payload; state.judges = []; })

      // POST
      .addCase(postJudge.pending, (state) => { state.postLoading = true; })
      .addCase(postJudge.fulfilled, (state, action) => { state.postLoading = false; state.postSuccess = true; state.message = 'Judge posted successfully'; state.judges = action.payload; })
      .addCase(postJudge.rejected, (state, action) => { state.postLoading = false; state.postError = true; state.message = action.payload; })

      // UPDATE
      .addCase(updateJudge.pending, (state) => { state.updateLoading = true; })
      .addCase(updateJudge.fulfilled, (state, action) => { state.updateLoading = false; state.updateSuccess = true; state.message = 'Judge updated successfully'; state.judges = action.payload; })
      .addCase(updateJudge.rejected, (state, action) => { state.updateLoading = false; state.updateError = true; state.message = action.payload;  })

      // DELETE
      .addCase(deleteJudge.pending, (state) => { state.deleteLoading = true; })
      .addCase(deleteJudge.fulfilled, (state, action) => { state.deleteLoading = false; state.deleteSuccess = true; state.message = 'Judge deleted successfully'; state.judges = action.payload; })
      .addCase(deleteJudge.rejected, (state, action) => { state.deleteLoading = false; state.deleteError = true; state.message = action.payload; });
  }
});

export const { reset, postReset, updateReset, deleteReset } = judgesSlice.actions;
export default judgesSlice.reducer;
