import React, { useState, useEffect } from "react";
import { useDropzone } from "react-dropzone";
import { useDispatch, useSelector } from "react-redux";

import { postUser, updateUser, postReset, updateReset } from '../features/userSlice';

const UserForm = ({ editingUser }) => {

    const dispatch = useDispatch();
    const webMediaURL = import.meta.env.VITE_API_WEBMEDIAURL;

    const { postLoading, postSuccess, postError, updateLoading, updateSuccess, updateError } = useSelector((state) => state.users);

    const [userDetails, setUserDetails] = useState({ userFirstname: '', userMidname: '', userSurname: '', userOfficeEmail: '', userWorkstation: '', userRole: ''});
    const [image, setImage] = useState(null);
    const [fileName, setFileName] = useState("Browse user profile picture");
    const [isSubmitting, setIsSubmitting] = useState(false);

    // When editing, populate user data
    useEffect(() => {
        if (editingUser) {
            setUserDetails({
                userFirstname: editingUser.userfname || '',
                userMidname: editingUser.userMidname || '',
                userSurname: editingUser.userSurname || '',
                userOfficeEmail: editingUser.userEmail || '',
                userWorkstation: editingUser.worktStation || '',
                userRole: editingUser.userRole || ''
            });

            // Check if image exists
            if (editingUser.userProfilePicPath) {
                setImage({
                    preview: `${webMediaURL}/${editingUser.userProfilePicPath}`,
                    existing: true, // mark as existing, not new file
                });
            }
        }
    }, [editingUser, webMediaURL]);

    // Clean up image preview
    useEffect(() => {
        return () => {
        if (image && image.preview && !image.existing) {
            URL.revokeObjectURL(image.preview);
        }
        };
    }, [image]);


    // inputs change
    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setUserDetails(prev => ({ ...prev, [name]: value }));
    };

    // Handle picture drop
    const onDrop = (acceptedFiles) => {
        const file = acceptedFiles[0];
        const preview = URL.createObjectURL(file);

        if (image && image.preview && !image.existing) {
        URL.revokeObjectURL(image.preview);
        }

        setImage({ file, preview });
        setFileName(file.name);
    };

    const { getRootProps, getInputProps } = useDropzone({
        accept: { 'image/jpeg': ['.jpeg', '.jpg'], 'image/png': ['.png'] },
        onDrop,
        multiple: false,
    });


    // Handle form submission
    const handleSubmit = (e) => {

        e.preventDefault();

        setIsSubmitting(true);

        const userData = new FormData();
        userData.append('userFirstname', userDetails.userFirstname);
        userData.append('userMidname', userDetails.userMidname);
        userData.append('userSurname', userDetails.userSurname);
        userData.append('userOfficeEmail', userDetails.userOfficeEmail);
        userData.append('userWorkstation', userDetails.userWorkstation);
        userData.append('userRole', userDetails.userRole);

        if (image?.file) {
        userData.append('userProfilePic', image.file);
        }

        if (editingUser) {
            userData.append('userID', editingUser.userID);
            dispatch(updateUser(userData));
        } else {
            dispatch(postUser(userData));
        }
    };

    const resetFormSubmission = () => {
        setIsSubmitting(false);
        setUserDetails({
            userFirstname: '',
            userMidname: '',
            userSurname: '',
            userOfficeEmail: '',
            userWorkstation: '',
            userRole: ''
        });
        setImage(null);
        setFileName("Browse user profile picture");
        dispatch(postReset());
        dispatch(updateReset());
    };

    const success = postSuccess || updateSuccess;
    const loading = postLoading || updateLoading;
    const error = postError || updateError;

    return (
        <div className="modal-dialog modal-lg col-6">
        <div className="modal-content px-4 py-3 pb-4">
            <div className="modal-header border-0">
            <h4 className="modal-title"><i className="bi bi-person-add me-1"></i> {editingUser ? "Edit User" : "Create User"}</h4>
            <button type="button" className="btn-close" data-bs-dismiss="modal" aria-label="Close" onClick={resetFormSubmission}></button>
            </div>

            <div className="modal-body">
            <div className="card border-0">
                {success ? (
                <div className="card border-0 bg-light py-5">
                    <div className="success-animation text-center">
                    <div className="d-flex justify-content-center">
                        <svg className="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                        <circle className="checkmark__circle" cx="26" cy="26" r="25" fill="none" />
                        <path className="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8" />
                        </svg>
                    </div>
                    <h4 className="mt-4">User {editingUser ? "updated" : "created"} successfully!</h4>
                    <button className="btn btn-outline-secondary mt-3" onClick={resetFormSubmission}>Add another user</button>
                    </div>
                </div>
                ) : (
                <form onSubmit={handleSubmit}>
                    <div className="d-flex align-items-start gap-4">
                    <div {...getRootProps()} className="dropzone bg-light border rounded-2" style={{ width: 265, height: 280, flexShrink: 0, display: "flex", alignItems: "center", justifyContent: "center", overflow: "hidden", border: "10px solid #ddd" }}>
                        <input {...getInputProps()} />
                        {!image ? (
                          <p className="text-muted fs-14">Drop profile picture</p>
                        ) : (
                          <img src={image.preview} alt="Preview" style={{ width: "95%", height: "95%", objectFit: "cover" }} />
                        )}
                    </div>

                    <div className="row g-3 w-100">
                        {['userFirstname', 'userMidname', 'userSurname'].map((field, idx) => (
                        <div className="col-md-4" key={idx}>
                            <div className="form-floating">
                            <input type="text" className="form-control" id={field} name={field} value={userDetails[field]} onChange={handleInputChange} placeholder={field} required />
                            <label htmlFor={field}>{field.replace('user', '').replace(/([A-Z])/g, ' $1')}</label>
                            </div>
                        </div>
                        ))}

                        <div className="col-12">
                        <div className="form-floating">
                            <input type="email" className="form-control" id="userOfficeEmail" name="userOfficeEmail" value={userDetails.userOfficeEmail} onChange={handleInputChange} placeholder="Office Email" required />
                            <label htmlFor="userOfficeEmail">Office Email</label>
                        </div>
                        </div>

                        <div className="col-12">
                        <div className="form-floating">
                            <select className="form-select" id="userWorkstation" name="userWorkstation" value={userDetails.userWorkstation} onChange={handleInputChange} required>
                            <option value=""></option>
                            <option value="Headquarters">Headquarters</option>
                            <option value="Dar Es Salaam">Dar Es Salaam</option>
                            <option value="Bukoba">Bukoba</option>
                            <option value="Tanga">Tanga</option>
                            </select>
                            <label htmlFor="userWorkstation">Workstation</label>
                        </div>
                        </div>

                        <div className="col-12">
                        <div className="form-floating">
                            <select className="form-select" id="userRole" name="userRole" value={userDetails.userRole} onChange={handleInputChange} required>
                            <option value=""></option>
                            <option value="Admin">Admin</option>
                            <option value="Content Manager">Content Manager</option>
                            </select>
                            <label htmlFor="userRole">User Role</label>
                        </div>
                        </div>

                        {error && (
                        <div className="col-12">
                            <div className="alert alert-danger py-2 px-3">{error}</div>
                        </div>
                        )}

                        <div className="col-12">
                        <button type="submit" className="btn btn-accent w-100 rounded-1 fs-16" disabled={isSubmitting || loading}>
                            {loading && <span className="spinner-border spinner-border-sm me-2" />}
                            {editingUser ? "Update" : "Create"} User
                        </button>
                        </div>
                    </div>
                    </div>
                </form>
                )}
            </div>
            </div>
        </div>
        </div>
    );
};

export default UserForm;