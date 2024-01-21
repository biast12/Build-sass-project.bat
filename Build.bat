@Echo Off
REM This script sets up a new SASS project
Title Setting up SASS project

Echo Setting up SASS project...

REM Verify Node.js and npm are installed
Where /Q node
IF %ERRORLEVEL% NEQ 0 (
	Echo Node.js is not installed or not found in PATH
	REM Open the Node.js download page in the default browser
	Start https://nodejs.org/en/download/
	rundll32.exe cmdext.dll,MessageBeepStub
	Pause
	Exit /B %ERRORLEVEL%
)
Where /Q npm
IF %ERRORLEVEL% NEQ 0 (
	Echo npm is not installed or not found in PATH
	REM Open the Node.js download page in the default browser
	Start https://nodejs.org/en/download/
	rundll32.exe cmdext.dll,MessageBeepStub
	Pause
	Exit /B %ERRORLEVEL%
)

REM Create necessary directories
IF NOT EXIST css Mkdir css
IF NOT EXIST img Mkdir img
IF NOT EXIST scripts Mkdir scripts
IF NOT EXIST scss Mkdir scss

REM Create initial SASS and JS files
Echo > scss\_variables.scss
Echo > scss\_mixins.scss
Echo > scss\_extends.scss
Echo > scripts\script.js

REM Create batch files for SASS commands
Echo npm run sass:run > sass-run.bat
Echo npm run sass:runcompressed > sass-runcompressed.bat
Echo npm run sass:watch > sass-watch.bat
Echo npm run sass:watchcompressed > sass-watchcompressed.bat

REM Create initial HTML file
(
	Echo ^<!DOCTYPE html^>
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

REM Create initial SCSS file with imports
(
	Echo // Import: Bootstrap.scss
	Echo @import "../node_modules/bootstrap/scss/bootstrap.scss";
	Echo // Import: _variables.scss, _mixins.scss, _extends.scss
	Echo @import "variables", "mixins", "extends";
) >> scss\style.scss

REM Initialize npm and install SASS and Bootstrap
Call npm init -y >NUL
IF %ERRORLEVEL% NEQ 0 (
	Echo npm init failed with error: %ERRORLEVEL%
	rundll32.exe cmdext.dll,MessageBeepStub
	Pause
	Exit /B %ERRORLEVEL%
)
Call npm i sass >NUL
IF %ERRORLEVEL% NEQ 0 (
	Echo npm i sass failed with error: %ERRORLEVEL%
	rundll32.exe cmdext.dll,MessageBeepStub
	Pause
	Exit /B %ERRORLEVEL%
)
Call npm i bootstrap >NUL
IF %ERRORLEVEL% NEQ 0 (
	Echo npm i bootstrap failed with error: %ERRORLEVEL%
	rundll32.exe cmdext.dll,MessageBeepStub
	Pause
	Exit /B %ERRORLEVEL%
)

REM Add SASS scripts to package.json
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
)) > package.json