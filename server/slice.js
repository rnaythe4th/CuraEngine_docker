const execSync = require("child_process").execSync;

const { dirname } = require("path");
const appDir = dirname(require.main.filename);
const filePath = `${appDir}/uploads`;

const sliceModel = (
  input_file,
  printer_def = "/root/PrinterConfig/creality_ender3pro.def.json"
) => {
  console.log("hello");
  const outputPath = `${appDir}/outputs/${input_file.split(".")[0]}.gcode`;
  const output = execSync(
    `CuraEngine slice -v -j ${printer_def} -o ${outputPath} -s roofing_layer_count=3 -l ${filePath}/${input_file}`,
    { encoding: "utf-8" }
  ); // the default is 'buffer'

  console.log("Output was:\n", output);
};

module.exports = { sliceModel };
