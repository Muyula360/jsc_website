
const VisitCounter = ({ id, visitcount }) => {

    let counter = 0;

    const div_id = id;
    const finalCount = visitcount;
  
    const interval = setInterval(() => {

        counter += Math.ceil(finalCount / 50);
        
        if ( counter >= finalCount ) {
            counter = finalCount;
            clearInterval(interval);
        }

        document.getElementById(div_id).innerText = counter;

    }, 80);
  
  
    return (
        <h5 id={ id } className="card-title fw-bold"><span></span></h5>
    )

}

export default VisitCounter