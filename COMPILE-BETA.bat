for %%a in (AUI.nsi) do "C:\Program Files (x86)\NSIS\makensis.exe" /DBUILD_BETA %%a
pause
for %%a in (AUI.nsi) do "C:\Program Files\NSIS\makensis.exe" /DBUILD_BETA %%a
pause
