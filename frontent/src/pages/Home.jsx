
import ServicesButtonDisplay from "../components/ServicesButtonDisplay";
import Footer from "../components/Footer";
import NewsUpdatesEvents from "../components/NewsUpdates";
import VisitCount from "../components/VisitCount";
import Leaders from "../components/Leaders";
import Collection from "../components/Collection";
import GetJudiciaryApp from "../components/GetJudiciaryApp";
import NewsUpdates from '../components/NewsUpdates';
import BillboardHighlights from '../components/BillBoard';


const Home = () => {
  return (
    <>     
    <div style={{ backgroundColor:'#D7F8FA' }}> 
      <BillboardHighlights/>
      {/* <ServicesButtonDisplay/>        */}      
      <Collection/>  
        <NewsUpdates/>   
      {/* <Leaders/> */}
    
       </div>
    </>
  )
}

export default Home