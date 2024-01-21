@Echo Off
Title Building sass project

Echo Building sass project

Mkdir css
Mkdir img
Mkdir scripts
Mkdir scss

Echo > scss\_variables.scss
Echo > scss\_mixins.scss
Echo > scss\_extends.scss
Echo > scripts\script.js

Echo npm run sass:run > sass-run.bat
Echo npm run sass:runcompressed > sass-runcompressed.bat
Echo npm run sass:watch > sass-watch.bat
Echo npm run sass:watchcompressed > sass-watchcompressed.bat

(
	Echo ^<!DOCType html^>
	Echo ^<html lang="en"^>
	Echo   ^<head^>
	Echo     ^<meta charset="UTF-8" /^>
	Echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0" /^>
	Echo     ^<title^>Document^</title^>
	Echo     ^<link rel="stylesheet" href="css/style.css" /^>
	Echo   ^</head^>
	Echo   ^<body^>
	Echo     ^<header^>^</header^>
	Echo     ^<nav^>^</nav^>
	Echo     ^<main^>^</main^>
	Echo     ^<footer^>^</footer^>
	Echo     ^<script src="scripts/script.js"^>^</script^>
	Echo   ^</body^>
	Echo ^</html^>
) >> index.html

(
	Echo // Import: Bootstrap.scss
	Echo @import "../node_modules/bootstrap/scss/bootstrap.scss";
	Echo // Import: _variables.scss, _mixins.scss, _extends.scss
	Echo @import "variables", "mixins", "extends";
) >> scss\style.scss

Call npm init -y >NUL
Call npm i sass >NUL
Call npm i bootstrap >NUL

(For /f "tokens=* delims=" %%A in ('Type package.json') Do (
	Echo %%A | Findstr /C:"\"scripts\"" >NUL
	If Not Errorlevel 1 (
		Echo   "scripts": {
		Echo     "sass:run": "sass scss/:css",
		Echo     "sass:runcompressed": "sass scss/:css --style compressed",
		Echo     "sass:watch": "sass --watch scss/:css",
		Echo     "sass:watchcompressed": "sass --watch scss/:css --style compressed",
	) else (
		Echo %%A
	)
)) > temp_package.json

Move /Y temp_package.json package.json