const db = require("../config/db").connection;

const createClass = (req, res) => {
  const obj = req.body;

  if (!obj.strength) {
    return res.status(400).json({ message: "strength is required!" });
  }
  if (!obj.year) {
    return res.status(400).json({ message: "year is required!" });
  }
  if (!obj.section) {
    return res.status(400).json({ message: "Section is required!" });
  }
  if (!obj.startYear) {
    return res.status(400).json({ message: "start year is required!" });
  }

  var str = "";

  if(obj.year < 10){
    str = str + "0";
  }
  str = str + obj.year + "-" + obj.section + "-" + obj.startYear;

  db.query(
    {
      sql: "INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)",
      timeout: 40000, // 40s
      values: [
        "CLASS",
        "CLASS_ID",
        "START_YEAR",
        "STRENGTH",
        "YEAR",
        "SECTION",
        str,
        obj.startYear,
        obj.strength,
        obj.year,
        obj.section,
      ],
    },
    function (error, results, fields) {
      if (error) {
        return res
          .status(500)
          .json({ message: "Something went wrong please try again later..." });
      } else {
        return res.status(200).json({
          message: "Class Created",
          class: {
            startYear: obj.START_YEAR,
            strength: obj.strength,
            year: obj.year,
            section: obj.section,
          },
        });
      }
    }
  );
};

const getClassID = (req, res) => {
  const obj = req.body;
  if (!obj.year) {
    return res.status(400).json({ message: "year is required!" });
  }
  if (!obj.section) {
    return res.status(400).json({ message: "section is required!" });
  }
  if (!obj.startYear) {
    return res.status(400).json({ message: "start year is required!" });
  }
  db.query(
    {
      sql: "SELECT ?? FROM ?? WHERE ??=? AND ??=? AND ??=?",
      values: [
        "CLASS_ID",
        "CLASS",
        "YEAR",
        obj.year,
        "SECTION",
        obj.section,
        "START_YEAR",
        obj.startYear,
      ],
    },
    (error, results, fields) => {
        if(error) return res.status(500).send("unkown error occured");
        else{
            if(results.length===0) return res.status(400).send("Class does not exist");
            else return res.json(results[0]);
        }
    }
  );
};

const getClassByID = (req, res) => {
    const obj = req.params;

    if(!obj.classID){
        return res.status(400).json({ message : "classId is required!"});
    }

    db.query(
        {
            sql : "SELECT * FROM ?? WHERE ??=?",
            timeout: 40000, // 40s
            values : [
                "CLASS",
                "CLASS_ID",
                obj.classID
            ]
        },
        (error,results,fields) => {
            if(error){
                return res.status(400).json("something went wrong");
            }

            return res.status(200).json(
                results
            );
        }
    )
}

const getClassByAcademicYear = (req, res) => {

  var obj = req.params;

  if(!obj.startYear){
    return res.status(400).json({ message:"MissingInputException: startYear is required!"});
  }

  db.query(
    {
      sql:"SELECT * FROM ?? WHERE ?? = ?",
      values:[
        "CLASS",
        "START_YEAR",
        obj.startYear
      ]
    }, (errors, results, fields) => {

      if(errors){
        return res.status(400).json({message: "SQLSkillIssueException: SQL Error!"})
      }

      if(results.length == 0){
        return res.status(200).json({message:"No Records!"})
      }

      return res.status(200).json({message:"Success!", data: results});

    }
  )

}

module.exports = {
    createClass,
    getClassByID,
    getClassID,
    getClassByAcademicYear
};
