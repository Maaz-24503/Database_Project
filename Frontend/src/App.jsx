/* eslint-disable react/jsx-no-comment-textnodes */
import { useState } from "react";
import React from "react";
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login2 from "./pages/Login2";
import NotFound from "./pages/NotFound";
import AdminHome from "./pages/AdminView/AdminHome";
import StudentHome from "./pages/StudentView/StudentHome";
import Assignments from "./pages/StudentView/Assignments";
import Attendance from "./pages/StudentView/Attendance";
import Grades from "./pages/StudentView/Grades";
import Schedule from "./pages/StudentView/Schedule";
import StudentCourseDetails from "./pages/StudentView/StudentCourseDetails";
import AssignmentPage from "./pages/StudentView/AssignmentPage";
import GuardianHome from "./pages/GuardianView/GuardianHome";
import Ledger from "./pages/GuardianView/Ledger";
import FacultyHome from "./pages/FacultyView/FacultyHome";
import APCreation from "./pages/FacultyView/APCreation";
import Courses from "./pages/FacultyView/Courses";
import EnterMarks from "./pages/FacultyView/EnterMarks";
import GuardianAttendance from "./pages/GuardianView/Attendance";
import GuardianGrade from "./pages/GuardianView/GuardianGrade";
import CreateCredentials from "./pages/AdminView/CreateCredentials";
import CreateArrears from "./pages/AdminView/CreateArrears";
import ClassDetails from "./pages/FacultyView/ClassDetails";
import StudentDetails from "./pages/FacultyView/StudentDetails";
import AssessmentCourse from "./pages/FacultyView/AssessmentCourse";
import AssessmentDetails from "./pages/FacultyView/AssessmentDetails";
import CreateAcademicYear from "./pages/AdminView/CreateAcademicYear";
import StudentFeeInquiry from "./pages/AdminView/StudentFeeInquiry";
import ForcePasswordReset from "./pages/AdminView/ForcePasswordReset";
import PasswordForghetti from "./pages/PasswordForghetti";
import CreateCourse from "./pages/AdminView/CreateCourse";
import CreateProgram from "./pages/AdminView/CreateProgram";
import AssignClassTeacher from "./pages/AdminView/AssignClassTeacher";
import CreateCLO from "./pages/AdminView/CreateCLO";
import AssessmentMarks from "./pages/FacultyView/AssessmentMarks";
import StudentList from "./pages/FacultyView/AMStudentList";
import AssignCourseTeacher from "./pages/AdminView/AssignCourseTeacher";
import EnrollStudent from "./pages/AdminView/EnrollStudent";
import DeenrollStudent from "./pages/AdminView/DeenrollStudent";

function App() {

    const [isLoggedIn, setisLoggedIn] = useState(false);

    React.useEffect(() => {
        const check = () => {
            const token = sessionStorage.getItem("token");
            console.log(token);
            if (token) return true;
            else return false;
        };
        setisLoggedIn(check);
    }, []);
    return (
        <BrowserRouter>
            {!isLoggedIn ? (
                <Routes>
                    <Route path="/" Component={Login2} />
                    <Route path="/PasswordForghetti" Component={PasswordForghetti}/>
                    <Route path="*" Component={NotFound} />
                </Routes>
            ) : (
                <Routes>
                    //routes for admin view
                    <Route path="/AdminHome" element={<AdminHome />} />

                    //Card routes
                    <Route path="/AdminHome/CreateUser" element={<CreateCredentials />}></Route>
                    <Route path="/AdminHome/CreateArrears" element={<CreateArrears />}></Route>
                    <Route path="/AdminHome/CreateAcademicYear" element={<CreateAcademicYear />}></Route>
                    <Route path="/AdminHome/StudentFeeInquiry" element={<StudentFeeInquiry />}></Route>
                    <Route path="/AdminHome/ForcePasswordReset" element={<ForcePasswordReset />}></Route>
                    <Route path="/AdminHome/CreateCourse" element={<CreateCourse />}></Route>
                    <Route path="/AdminHome/CreateProgram" element={<CreateProgram />}></Route>
                    <Route path="/AdminHome/AssignClassTeacher" element={<AssignClassTeacher />}></Route>
                    <Route path="/AdminHome/CreateCLO" element={<CreateCLO/>}></Route>
                    <Route path="/AdminHome/AssignCourseTeacher" element={<AssignCourseTeacher/>}></Route>
                    <Route path="/AdminHome/EnrollStudent" element={<EnrollStudent/>}></Route>
                    <Route path="/AdminHome/DeenrollStudent" element={<DeenrollStudent/>}></Route>

                    
                    //routes for student view
                    <Route path="/StudentHome" element={<StudentHome />} />
                    <Route path="/Assignments" element={<Assignments />} />
                    <Route path="/Attendance" element={<Attendance />} />
                    <Route path="/Grades" element={<Grades />} />
                    <Route path="/Schedule" element={<Schedule />} />
                    <Route path="/StudentCourseDetails" element={<StudentCourseDetails />} />
                    <Route path="/AssignmentPage" element={<AssignmentPage />} />

                    //routes for guardian view
                    <Route path="/GuardianHome" element={<GuardianHome />} />
                    <Route path="/Ledger" element={<Ledger />} />
                    <Route path="/GuardianAttendance" element={<GuardianAttendance />} />
                    <Route path="/GuardianGrade" element={<GuardianGrade />} />
                    
                    //routes for faculty view
                    <Route path="/FacultyHome" element={<FacultyHome />} />
                    <Route path="/Courses" element={<Courses />} />
                    <Route path="/EnterMarks" element={<EnterMarks />} />
                    <Route path="/EnterMarks/AssessmentList" element={<AssessmentMarks />} />
                    <Route path="/ClassDetails" element={<ClassDetails />} />
                    <Route path="/ClassDetails/StudentDetails" element={<StudentDetails />} />
                    <Route path="/APCreation" element={<APCreation />} />
                    <Route path="/APCreation/AssessmentCourse" element={<AssessmentCourse />} />
                    <Route path="/AssessmentCourse/AssessmentDetails" element={<AssessmentDetails />}/>
                    <Route path="/AssessmentCourse/AssessmentDetails/StudentList" element={<StudentList />}/>
                    //not FOUND
                    <Route path="*" Component={NotFound} />
                </Routes>
            )}
        </BrowserRouter>
    );
}

export default App;