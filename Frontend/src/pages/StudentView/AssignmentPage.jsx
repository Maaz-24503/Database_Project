import React, {useEffect, useState} from 'react'
import { decryptToken } from '../../apis/auth/getUserType';
import SimpleBackdrop from '../../components/util-components/Loader';
import StudentNavbar from "../../components/Navbars/StudentNavbar";

const AssignmentPage = () => {
    const [render, setRender] = useState(false);
    useEffect(()=>{
  
      const checkUserType = async () =>{
        const token = sessionStorage.getItem("token");
        const decryptedToken = await decryptToken(token);
        const userType = decryptedToken.data["userType"];
        // console.log(userType);
        if( userType !== "STUDENT"){
          window.location.assign("/UNATHORIZEDACCESS");
        }
        else setRender(true);
      }
      
      checkUserType();
    });
  
    
    return (
      <>{render ? (
        <>
        <div className="div1">
        <StudentNavbar />
        AssignmentPage</div>
        <div className="S1">
        AssignmentTitle
        </div>
      </>
        
        
        ): (<SimpleBackdrop currentOpenState={true} handleClose={() => {}}></SimpleBackdrop>)}</>
      
    )
}

export default AssignmentPage