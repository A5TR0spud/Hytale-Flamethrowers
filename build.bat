@echo off
SETLOCAL EnableDelayedExpansion
mkdir "builds"
powershell -Command "&{Remove-Item builds\* -Exclude '*.zip' -Recurse -Force}
set v="indev"
> "builds\ver.tmp" powershell -Nop -C "(Get-Content .\manifest.json|ConvertFrom-Json).Version"&&<"builds\ver.tmp" (set /p v=)&&del "builds\ver.tmp" /q
> "builds\manifest.json" (
    FOR /f "delims=*" %%a IN (manifest.json) DO (
        set b=%%a
        echo !b:Indev=!
    )
)
xcopy "Server" "builds\Server\" /e
xcopy "Common" "builds\Common\" /e
del "builds\A5TR0spud.Flamethrowers-!v!.zip" /q
powershell -Command "Compress-Archive -Path 'builds\*' -DestinationPath 'builds\A5TR0spud.Flamethrowers-!v!.zip'"
rmdir "builds\Server" /s /q /f
rmdir "builds\Common" /s /q /f
del "builds\manifest.json" /q
del "%~dp0..\..\..\..\Mods\A5TR0spud.Flamethrowers*.zip" /q
copy "builds\A5TR0spud.Flamethrowers-!v!.zip" %~dp0..\..\..\..\Mods
endlocal