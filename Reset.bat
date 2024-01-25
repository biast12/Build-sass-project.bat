@Echo Off
Set "Excluded=.gitignore Build.bat Build-Choice.bat README.md Reset.bat"

For /D %%A In (*) Do (
	If Not "%%~nxA"=="%~nx0" (
		Echo %Excluded% | Find /I "%%~nxA" > nul
		If ErrorLevel 1 (
			RD /s /q "%%A"
		)
	)
)

For %%A In (*) Do (
	If Not "%%~nxA"=="%~nx0" (
		Echo %Excluded% | Find /I "%%~nxA" > nul
		If ErrorLevel 1 (
			Del "%%A"
		)
	)
)
