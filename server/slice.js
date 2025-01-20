const execSync = require("child_process").execSync;

const { dirname } = require("path");
const appDir = dirname(require.main.filename);
const filePath = `${appDir}/uploads`;
let filamentUsed = 0.0;

const sliceModel = (
  input_file,
  printer_def = "/root/PrinterConfig/creality_ender3pro.def.json"
) => {
  console.log("hello");
  const outputPath = `${appDir}/outputs/${input_file.split(".")[0]}.gcode`;
  const output = execSync(
    `CuraEngine slice -v -j ${printer_def} -o ${outputPath} -s roofing_layer_count="3" -s retraction_combing_avoid_distance=0.8 -s support_z_seam_away_from_model=true -l ${filePath}/${input_file}`,
    { encoding: "utf-8" }
  ); // the default is 'buffer'

  const match = output.match(/Filament \(mm\^3\): (\d+)/);

// Если строка найдена, извлекаем значение
if (match) {
  filamentUsed = match[1]; // значение в миллиметрах кубических
  console.log("Filament used:", filamentUsed); // Выводим результат
  // Здесь можно отправить данные клиенту
  return filamentUsed
} else {
  console.log('Не удалось найти информацию о филаменте.');
}

  //console.log("Output was:\n", output);
};

module.exports = { sliceModel };
