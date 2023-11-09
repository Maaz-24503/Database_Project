const express = require("express");
const tryCatch = require("../middleware/tryCatch");

var router = express.Router();
var guardianService = require("../services/guardianService");
var financeService = require("../services/financeService");

router.post("/createGuardian", tryCatch(guardianService.createGuardian));
router.post("/createGuardianPayment", tryCatch(financeService.createGuardianPayment));

router.get("/getAllChildren/:guardianId", tryCatch(guardianService.getChildren));
router.get("/getAllChildrenAttendance/:guardianId", tryCatch(guardianService.getChildrenAttendance));
router.get("/getChildrenFee/:id", tryCatch(financeService.getStudentFee));
router.get("/getStudentLedger/:id", tryCatch(financeService.generateStudentLedger));
module.exports = router;