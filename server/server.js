const express = require("express");
const app = express();
const multer = require("multer");
const { sliceModel } = require("./slice");
const path = require("path");
require("dotenv").config();
const { dirname } = require("path");
const appDir = dirname(require.main.filename);
const cors = require('cors');


app.use(cors({
  origin: 'http://localhost:5173', // allow requests from localhost only
  methods: ['GET', 'POST'],
}));

app.use(express.urlencoded({ extended: false, limit: "50mb" }));

console.log(process.env.NODE_PATH);

const PORT = process.env.PORT || 3000;

const uploadGcode = false;

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, `${appDir}/uploads`);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname);
  },
});

const upload = multer({ storage: storage });

app.get("/", (req, res) => {
  res.send("hi");
});

app.post("/slice", upload.single("uploaded_file"), (req, res) => {
  console.log(req.file);
  const filamentused = sliceModel(req.file.filename);
  if (uploadGcode) {
    res.download(`${appDir}/outputs/${req.file.filename.split(".")[0]}.gcode`);
  } else {
    res.json(filamentused);
  }
  
});

app.listen(PORT, () => {
  console.log(`server running on ${PORT}`);
});
