import React, { useState, useEffect, useRef } from "react";
import { useDispatch, useSelector } from "react-redux";
import { formatTableDate } from "../utils/dateUtils";
import { toast } from "react-toastify";


import { getUserNotifications, updateNotificationRead } from "../features/notificationSlice";

const ContentsMgrNotification = () => {

  const dispatch = useDispatch();
  
  const webUrl = import.meta.env.VITE_API_WEBURL;
  const iconsPath = webUrl+'/src/assets/icons';

  const { notifications, isLoading, deleteLoading, isSuccess, deleteSuccess, isError, deleteError } = useSelector((state) => state.notifications);

  const [notificationsList, setNotificationsList] = useState([]);
  const [search, setSearch] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [notificationsPerPage, setNotificationsPerPage] = useState(5);
  const [selectedNotification, setSelectedNotification] = useState([]);


  // get notifications when this page/component loads
  useEffect(() => {
    dispatch(getUserNotifications());
  }, [dispatch]);
  

  // after fetching notifications successfully assign fetched notifications to the notificationsList array
  useEffect(() => {
    if (isSuccess) {
      setNotificationsList(notifications);
    }
    if (isError) {
      toast.error("Failed to fetch notifications.");
    }
  }, [notifications, isSuccess, isError]);


  // tooltip
  useEffect(() => {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    const tooltipList = tooltipTriggerList.map((tooltipTriggerEl) => {
      return new window.bootstrap.Tooltip(tooltipTriggerEl, {
        trigger: 'hover'
      });
    });

    // Cleanup: Dispose tooltips on unmount/re-render to avoid duplicates
    return () => {
      tooltipList.forEach((tooltip) => tooltip.dispose());
    };
  }, [notificationsList, currentPage]);


  // Search + Filter
  const filteredData = notificationsList.filter((item) =>
    [item.notificationTitle, item.notificationDesc]
    .join(" ")
    .toLowerCase()
    .includes(search.toLowerCase())
  );

  const totalItems = filteredData.length;
  const totalPages = Math.ceil(totalItems / notificationsPerPage);
  const startItem = (currentPage - 1) * notificationsPerPage + 1;
  const endItem = Math.min(currentPage * notificationsPerPage, totalItems);
  const currentItems = filteredData.slice(startItem - 1, endItem);

  const handlePageChange = (pageNumber) => {
    if (pageNumber >= 1 && pageNumber <= totalPages) {
      setCurrentPage(pageNumber);
    }
  };


  // notifications pagination
  const renderPagination = () => {
    return Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
      <li key={page} className={`page-item ${currentPage === page ? "active" : ""}`} >
        <button className="page-link btn-sm" onClick={() => handlePageChange(page)} >
          {page}
        </button>
      </li>
    ));
  };


  // handle notification read 
  const handleReadNotification = (notificationID) => {
    dispatch(updateNotificationRead(notificationID))
      .unwrap()
      .then(() => toast.success("Notification marked as read"))
      .catch(() => toast.error("Failed to mark this notification as read"));
  };


  // notifications Alerts UI
  return (
    <div className="container-fluid py-3">
        <div className="d-flex justify-content-between mb-5">
            <div className="w-50">
                <input type="text" className="form-control rounded-2 py-2 px-4" placeholder="Search ..." value={search} onChange={(e) => setSearch(e.target.value)} />
            </div>
            <div className="">
                <select className="form-select form-select" value={notificationsPerPage} onChange={(e) => { setNotificationsPerPage(Number(e.target.value)); setCurrentPage(1); }} >
                    {[5, 10, 15].map((num) => (
                    <option key={num} value={num}>
                        {num}
                    </option>
                    ))}
                </select>
            </div>
        </div>

        {/* notification title*/}
        <div className="d-flex justify-content-between align-items-center mb-5">
            <div>
                <h4>Notifications</h4>
                <small className="text-secondary fs-15">You have <span className="text-accent">{ notificationsList.filter(item => item.readStatus === 0).length }</span> notifications to go through</small>
            </div>
            <div className="">
                <button type="button" className="btn btn-outline-secondary">Mark all as Read</button>
            </div>
        </div>


        {/* notification preview modal */}
        <div className="modal fade" id="notificationPreviewCard" data-bs-backdrop="static" data-bs-keyboard="false" tabIndex="-1" aria-labelledby="notificationPreviewCardLabel" aria-hidden="true" >
            
        </div>


        {/* notifications display */}
        <div>
            <h6 className="text-secondary mx-1 mb-2">Today</h6>
            <ul className="p-0">
                {currentItems.map((item, index) => (
                    <li key={item.notificationID || index} className="list-group-item bg-white py-3 px-4 border-0 rounded-3 mb-3">
                        <div className="d-flex align-items-center gap-3">

                          <div style={{ width: '40px' }}>
                              <img src={ `${iconsPath}/notification-bell.png` } alt="Notification Icon" style={{ width: "100%" }} className="rounded-5"/>
                          </div>
                          <div className="flex-grow-1">
                              <h6 className="text-heading-secondary">{item.notificationTitle} . <small className="text-accent-secondary small"> { formatTableDate(item.createdAt) }</small></h6>
                              <p className="text-secondary m-0 fs-14">{item.notificationDesc}</p>
                          </div>
                          <div className="">
                            <button className="btn btn-light text-accent px-2 py-1 rounded-5" onClick={() => handleReadNotification(item.notificationID)} data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Mark as read">
                              {item.readStatus === 0 ? (
                                <i className="bi bi-envelope text-accent"></i>
                              ) : (
                                <i className="bi bi-envelope-open text-dark"></i>
                              )}
                            </button>
                          </div>

                        </div>
                    </li>
                ))}

                {currentItems.length === 0 && (
                  <li className="list-group-item p-4 border-0 rounded-2 mb-2 bg-white">
                    <div className="text-center">
                      <p className="text-secondary m-0">No notifications found.</p>
                    </div>
                  </li>
                )}
            </ul>
        </div>

        {/* Pagination */}
        <nav className="d-flex justify-content-between align-items-center mt-4">
        <span>
            Showing {startItem}-{endItem} of {totalItems}
        </span>
        <ul className="pagination mb-0">
            <li className="page-item">
            <button className="page-link btn-sm" onClick={() => handlePageChange(currentPage - 1)} disabled={currentPage === 1} >
                <i className="bi bi-chevron-left"></i>
            </button>
            </li>
            {renderPagination()}
            <li className="page-item">
            <button className="page-link btn-sm" onClick={() => handlePageChange(currentPage + 1)} disabled={currentPage === totalPages} >
                <i className="bi bi-chevron-right"></i>
            </button>
            </li>
        </ul>
        </nav>

    </div>
  );
};



export default ContentsMgrNotification