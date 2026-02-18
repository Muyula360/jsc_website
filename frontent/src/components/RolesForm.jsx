import React, { useState } from "react";
import { useDropzone } from "react-dropzone";



const RolesForm = () => {     

    return (
      <>
         <div className="modal-dialog modal-lg col-10">
            <div className="modal-content ">
                <div className="modal-header pt-3 pb-0 border-0">
                    <h5 className="modal-title" id="staticBackdropLabel1">New Role</h5>
                    <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div className="modal-body pt-3">
                    <div className="card border-0 custom-card p-4">
                    <form action="">
                      <div className="d-flex align-items-start gap-3">
                      {/* Image Upload Section */}
                      <div className="border rounded text-center position-relative cover-photo" >
                        <img src="/user.png" alt="Profile Photo" className="user-png " />
                       </div>

                      {/* Form Inputs Section */}
                      <div className="flex-grow-1">
                      <div className="row justify-content-center mb-2">
                        <div className="col-md-6 mb-3">
                        <div className="form-floating">
                            <input type="text" className="form-control form-control-sm" id="rolename" placeholder="Role Name" />
                            <label htmlFor="rolename">Role Name</label>
                        </div>
                        </div>
                        <div className="col-md-6 mb-3">
                                <div className="form-floating">
                                <select className="form-select form-select-sm" id="rolename">
                                    <option value="" disabled selected></option>
                                    <option value="judge">Level I</option>
                                    <option value="commissioner">Level II</option>
                                    <option value="legal-advisor">Level III</option>
                                </select>
                                <label htmlFor="rolename">Role Level</label>
                                </div>
                            </div>
                      </div>
                      <div className="row justify-content-center mb-3">
                        <div className="col-md-12 mb-3">
                            <div className="form-floating">
                                <textarea className="form-control form-control-sm" id="description" placeholder="Role Description"></textarea>
                                <label htmlFor="description">Role Description</label>
                            </div>
                         </div>
                       </div>

                      <button type="submit" className="btn btn-danger w-100">Post</button>
                      </div>
                      </div>

                        </form>
                    </div>

                </div>
            </div>
         </div>
     
        </>
    );
  }
  
export default RolesForm