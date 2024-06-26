import { axiosInstance } from "../axios";

export default function numbNuts() {

}

//userService
export async function createUser(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createUser', data, { headers: headers });
        if (res.status === 200) {
            console.log("SUCCESS");
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

//financeService
export async function createArrearsByGrade(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createArrearsByGrade', data, { headers: headers });
        if (res.status === 200) {
            console.log("SUCCESS");
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

export async function createArrearsByGradeID(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createArrearsByGradeID', data, { headers: headers });
        if (res.status === 200) {
            console.log("SUCCESS");
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

export async function createArrearsByStudentID(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createArrearsByStudentID', data, { headers: headers });
        if (res.status === 200) {
            console.log("SUCCESS");
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

export async function createArrearsByAcademicYear(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createArrearsByAcademicYear', data, { headers: headers });
        if (res.status === 200) {
            console.log("SUCCESS");
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

//academicYearService
export async function createAcademicYearWithDays(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createAcademicYearWithDays', data, { headers: headers });
        if (res.status === 200) {
            console.log("SUCCESS");
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

//tfaService
export async function createTFAKey(data) {
    try {

        let headers = {
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createTFAKey', data, { headers: headers });
        if (res.status === 200) {
            return res;
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

//courseService
export async function createCourse(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createCourse', data, { headers: headers });
        if (res.status === 200) {
            return res.data;
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

//programService
export async function createProgram(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/createProgram', data, { headers: headers });
        if (res.status === 200) {
            return res.data;
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

export async function CourseTeacher(data, token) {
    try {

        let headers = {
            "Authorization": token,
            "Content-Type": "application/json",
        };

        const res = await axiosInstance.post('admin/AssignCourseTeacher', data, { headers: headers });
        if (res.status === 200) {
            return res.data;
        } else {
            console.log("Something's wrong I can feel it");
        }
    } catch (ex) {
        return ex;
    }
}

//adminService
export async function ClassTeacher(data, token) {

    let headers = {
        "Authorization": token,
        "Content-Type": "application/json",
    };

    const res = await axiosInstance.post(`/admin/assignClassTeacher`, data, { headers: headers });
    //console.log(res.data.results);
    if (res.status == 200) {
        return res.data;
    } else {
        console.log("Something's wrong I can feel it");
    }

}

//cloService
export async function CLO(data, token) {
    let headers = {
        "Authorization": token,
        "Content-Type": "application/json",
    };

    const res = await axiosInstance.post(`/admin/createCLO`, data, { headers: headers });
    //console.log(res.data.results);
    if (res.status == 200) {
        return res.data;
    } else {
        console.log("Something's wrong I can feel it");
    }
}

//ploService
export async function PLO(data, token) {
    let headers = {
        "Authorization": token,
        "Content-Type": "application/json",
    };

    const res = await axiosInstance.post(`/admin/createPLO`, data, { headers: headers });
    //console.log(res.data.results);
    if (res.status == 200) {
        return res.data;
    } else {
        console.log("Something's wrong I can feel it");
    }
}

//enrollmentService
export async function StudentToClass(data, token) {
    let headers = {
        "Authorization": token,
        "Content-Type": "application/json",
    };

    const res = await axiosInstance.post(`/admin/enrollStudentToClass`, data, { headers: headers });

    if (res.status == 200) {
        return res.data;
    } else {
        console.log("Something's wrong I can feel it");
    }
}

export async function StudentOuttaClass(data, token) {
    let headers = {
        "Authorization": token,
        "Content-Type": "application/json",
    };

    const res = await axiosInstance.patch(`/admin/denrollStudentFromClass`, data, { headers: headers });

    if (res.status == 200) {
        return res.data;
    } else {
        console.log("Something's wrong I can feel it");
    }
}