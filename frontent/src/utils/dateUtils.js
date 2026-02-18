export function formatDate(dateString) {

  const date = new Date(dateString);
  
  // Format date part (25 Jan, 2025)
  const datePart = new Intl.DateTimeFormat('en-GB', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(date);
  
  // Format time part (08:48am)
  const timePart = new Intl.DateTimeFormat('en-US', {
    hour: '2-digit',
    minute: '2-digit',
    hour12: true
  }).format(date);
  
  return `${datePart} At ${timePart}`;
  
}

export function returnDate(dateString) {

  const date = new Date(dateString);
  
  // Format date part (25 Jan, 2025)
  const datePart = new Intl.DateTimeFormat('en-GB', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(date);
  
  return `${datePart}`;
  
}


export function formatTableDate(dateString) {

  const dateOptions = { day:'numeric', month:'numeric', year:'numeric', hour:'2-digit', minute:'2-digit', timeZone:'UTC' }
  const formattedDate = new Date(dateString).toLocaleDateString('en-UK', dateOptions);
  
  return `${formattedDate}`;
  
}

// within 20 days is considered as recent
export function  isRecent(postedDate) {

  const today = new Date();
  const postDate = new Date(postedDate);
  const diffDays = Math.floor((today - postDate) / (1000 * 60 * 60 * 24));
  return diffDays <= 20;

};
