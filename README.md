## 3D print Server (Docker + Node.JS)

Часть пет-проекта — серверное приложение на **Node.js** в **Docker-контейнере**.

iOS-клиент и Web-клиент:

[![GitHub](https://img.shields.io/badge/GitHub-3d_print_client_(iOS)-blue?logo=github)](https://github.com/rnaythe4th/3d-print-client-ios)
[![GitHub](https://img.shields.io/badge/GitHub-3d_print_site_(React)-blue?logo=github)](https://github.com/rnaythe4th/3d-print-site-react)


#### Описание
Этот **Docker-контейнер** содержит **Ubuntu Linux** и **Node.js** сервер, который:
- Принимает **POST-запросы** с **.stl 3D-моделями**.
- Нарезает модель в **G-code**.
- Извлекает из G-code требуемую информацию (время печати, масса материала, количество слоёв и т.д.)
- Отправляет полученную информацию **обратно клиенту**.
- Позволяет **анализировать вывод терминала** и извлекать конкретные данные (например, объем использованного материала).

Для нарезки используется CLI движка [CuraEngine](https://github.com/Ultimaker/CuraEngine) с пресетами для конкретного 3D-принтера. 

> ⚠ **Внимание:** CuraEngine собирается из исходного кода, поэтому создание образа займёт некоторое время.

#### Использование
По умолчанию контейнер запускается в папке с сервером. Для старта сервера используйте:

```sh
node server.js
```

Сервер использует порт 8080.

<br>
• • • • • • • • • • • • • •

• • • • • • • • • • • • • •



### Описание решаемой проблемы:
Быстро узнать цену 3D-печати нужной модели на заказ практически невозможно. В поисковой выдаче по запросу "3D-печать на заказ <город>" большинство сайтов либо позволяют только оформить заявку с последующим рассмотрением менеджерами, либо указывают лишь цену печати за 1 грамм материала без учета особенностей модели.
### Решение проблемы:
Создание системы со следующим принципом работы:<br>
1. Клиент (web, mobile) позволяет пользователю загрузить имеющуюся 3D-модель из файла.
2. Затем клиент отправляет модель на сервер.
3.Сервер нарезает модель, как это делает слайсер (ПО для подготовки модели к 3D-печати), и извлекает из полученного файла объем израсходованного материала в мм³.
4. Сервер отправляет полученные данные обратно клиенту
5. Клиент получает значение и рассчитывает итоговую стоимость печати по заранее заданной формуле, учитывая цену пластика и наценку.


---

## 3D Print Server (Docker + Node.js)

Part of a pet project — a **Node.js** server application running in a **Docker container**.

### iOS and Web Clients:

[![GitHub](https://img.shields.io/badge/GitHub-3D_Print_Client_(iOS)-blue?logo=github)](https://github.com/rnaythe4th/3d-print-client-ios)
[![GitHub](https://img.shields.io/badge/GitHub-3D_Print_Site_(React)-blue?logo=github)](https://github.com/rnaythe4th/3d-print-site-react)

### Description  
This **Docker container** includes **Ubuntu Linux** and a **Node.js** server that:  
- Accepts **POST requests** with **.stl 3D models**.  
- Slices the model into **G-code**.  
- Extracts required data from the G-code (print time, material weight, number of layers, etc.).  
- Sends the processed information **back to the client**.  
- Allows **terminal output analysis** to retrieve specific data (e.g., material consumption).  

The slicing process is performed using the [CuraEngine](https://github.com/Ultimaker/CuraEngine) CLI, configured with presets for a specific 3D printer.  

> ⚠ **Note:** CuraEngine is built from source, so the image creation process may take some time.

### Running the Server  
By default, the container starts in the server's directory.  

To start the server, run:
```sh
node server.js
```
The server runs on port 8080.


<br>
• • • • • • • • • • • • • •

• • • • • • • • • • • • • •


#### Problem Statement  
It’s nearly impossible to quickly estimate the cost of custom 3D printing for a specific model. Search results for "custom 3D printing in <city>" typically show websites that either:  
- Require submitting a request for manual review by managers, or  
- Only display the price per gram of material without considering the model’s complexity.  

#### Solution  

A system with the following workflow: 

1. **Client** (web/mobile): Lets users upload a 3D model from a file.  
2. The client sends the model to the **server**.  
3. **Server**: Slices the model (similar to slicer software used in 3D printing preparation) and calculates the material volume in mm³.  
4. The server returns the extracted data to the client.  
5. **Client**: Calculates the final cost using a predefined formula that accounts for material price and markup.  