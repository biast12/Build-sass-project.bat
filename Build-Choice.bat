@Echo Off
REM This script sets up a new SASS project

REM Prompt user for module installation choice
Title Which modules do you want to install?
Echo Which modules do you want to install?
Echo ===========================================
Echo.
Echo [1] Sass
Echo [2] Sass and Bootstrap
Echo.
Choice /c:"12" /N /M:"Enter: "
Set Choice=%ERRORLEVEL%
CLS

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
copy nul scss\_variables.scss >NUL
copy nul scss\_mixins.scss >NUL
copy nul scss\_extends.scss >NUL
copy nul scripts\script.js >NUL

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
(
	Echo // Import: _variables.scss, _mixins.scss, _extends.scss
	Echo @import "variables", "mixins", "extends";
) >> scss\style.scss

REM Initialize npm
Call npm init -y >NUL
IF %ERRORLEVEL% NEQ 0 (
	Echo npm init failed with error: %ERRORLEVEL%
	Exit /B %ERRORLEVEL%
)

REM Check user's choice and jump to the corresponding section
If "%Choice%"=="1" Goto :Sass
If "%Choice%"=="2" Goto :Both

REM Install Sass
:Sass
Call npm i sass >NUL
IF %ERRORLEVEL% NEQ 0 (
	Echo npm i sass failed with error: %ERRORLEVEL%
	rundll32.exe cmdext.dll,MessageBeepStub
	Pause
	Exit /B %ERRORLEVEL%
)
Goto :continue

REM If user chose Sass and Bootstrap, add Bootstrap import to style.scss
:Both
(
	Echo // Import: Bootstrap.scss
	Echo @import "../node_modules/bootstrap/scss/bootstrap.scss";
) >> scss\temp_style.scss
Type scss\style.scss >> scss\temp_style.scss
Move /Y scss\temp_style.scss scss\style.scss >NUL 2>&1

REM Install Sass and Bootstrap
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

:continue
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
)) > temp_package.json

REM Replace original package.json with the modified one
Move /Y temp_package.json package.json >NUL 2>&1