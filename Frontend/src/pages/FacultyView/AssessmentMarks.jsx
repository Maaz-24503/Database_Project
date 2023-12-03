import React, { useEffect, useState, setState } from "react";
import { decryptToken } from "../../apis/auth/getUserType";
import SimpleBackdrop from "../../components/util-components/Loader";
import FacultyNavbar from "../../components/Navbars/FacultyNavbar";
import {
    createAssessment,
    getAssessmentsByCourseId,
} from "../../apis/Faculty/Assessments";
import dayjs from "dayjs";
import AMTable from "../../components/FacultyComponents/AMTable";

const AssessmentMarks = () => {
    const [loading, setLoading] = useState(false);
    const [Assessments, setAssessments] = useState([]);
    const [date, setDate] = useState(dayjs());
    const [maxMarks, setMax] = useState();
    const [title, setTitle] = useState();

    useEffect(() => {
        const getDetail = async () => {
            const token = sessionStorage.getItem("token");
            if (!token) {
                window.location.assign("/notfound");
            }
            const decryptedToken = await decryptToken(token);

            if (decryptedToken.data.userType != "FACULTY") {
                window.location.assign("/notfound");
            }
            sessionStorage.setItem("facultyId", decryptedToken.data.id);
            const table = await getAssessmentsByCourseId(
                sessionStorage.getItem("courseId"),
                decryptedToken.data.id,
                token
            );
            setAssessments(table.results);

            setLoading(false);
        };

        setLoading(true);
        getDetail();
    }, []);

    const assessmentAdded = async () => {
        if (title && maxMarks > 0) {
            var obj = {
                assessmentTitle: title,
                maxMarks: maxMarks,
                assessmentDate: date,
                facultyId: sessionStorage.getItem("facultyId"),
                courseId: sessionStorage.getItem("courseId"),
                classId: sessionStorage.getItem("classId"),
            };
            var api = await createAssessment(
                obj,
                sessionStorage.getItem("token")
            );
            window.location.reload(false);
        }
    };

    return (
        <>
            {loading ? (
                <SimpleBackdrop
                    currentOpenState={true}
                    handleClose={() => {}}
                />
            ) : (
                <div className="div1">
                    <FacultyNavbar />
                    <h1>{sessionStorage.getItem("courseId")}</h1>
                    <h2>{sessionStorage.getItem("classId")}</h2>
                    <AMTable contents={Assessments} />
                </div>
            )}
        </>
    );
};

export default AssessmentMarks;
