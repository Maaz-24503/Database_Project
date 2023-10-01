const express = require("express");
const tryCatch = require("../middleware/tryCatch");

var router = express.Router();
var adminService = require("../services/adminService");
var classService = require("../services/classService");
var financeService = require("../services/financeService");
var facultyService = require("../services/facultyService");
var studentService = require("../services/studentService");

router.post("/createAdmin", tryCatch(adminService.createAdmin));
router.post("/createClass", tryCatch(classService.createClass));
router.post("/getClassID", tryCatch(classService.getClassID));
router.post("/createAcademicYear", tryCatch(adminService.createAcademicYear));
router.post("/createArrearsByGrade", tryCatch(financeService.createArrearsByGrade));
router.post("/createArrearsByAcademicYear", tryCatch(financeService.createArrearsByAcademicYear));
router.post("/createArrearsByStudentID", tryCatch(financeService.createArrearsByStudentID));

router.post("/createStudent", tryCatch(studentService.createStudent));
router.get("/getStudentByID/:id", tryCatch(studentService.getStudentById));

router.post("/createFaculty", tryCatch(facultyService.createFaculty));

router.patch("/deleteTransactionByID", tryCatch(financeService.deleteTransactionByID));
router.patch("/restoreTransactionByID", tryCatch(financeService.restoreTransactionByID));
router.patch("/deleteTransactionByName", tryCatch(financeService.deleteTransactionByName));
router.patch("/restoreTransactionByName", tryCatch(financeService.restoreTransactionByName));

router.get("/getStudentFee/:id", tryCatch(financeService.getStudentFee));
router.get("/generateStudentLedger/:id", tryCatch(financeService.generateStudentLedger));



module.exports = router