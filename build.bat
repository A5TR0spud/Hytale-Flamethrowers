@echo off
SETLOCAL EnableDelayedExpansion
mkdir "builds"
powershell -Command "&{Remove-Item builds\* -Exclude '*.zip' -Recurse -Force}
mkdir "builds\building"
set v="indev"
> "builds\building\ver.tmp" powershell -Nop -C "(Get-Content .\manifest.json|ConvertFrom-Json).Version"&&<"builds\building\ver.tmp" (set /p v=)&&del "builds\building\ver.tmp" /q
> "builds\building\manifest.json" (
    FOR /f "delims=*" %%a IN (manifest.json) DO (
        set b=%%a
        echo !b:Indev=!
    )
)
xcopy "Server" "builds\building\Server\" /e
xcopy "Common" "builds\building\Common\" /e
del "builds\A5TR0spud.Flamethrowers-!v!.zip" /q
powershell -Command "Compress-Archive -Path 'builds\building\*' -DestinationPath 'builds\A5TR0spud.Flamethrowers-!v!.zip'"
rmdir "builds\building\" /s /q
if "%~dp0..\..\.."=="mods\*\Saves\" (
    del "%~dp0..\..\..\..\Mods\A5TR0spud.Flamethrowers*.zip" /q
    copy "builds\A5TR0spud.Flamethrowers-!v!.zip" %~dp0..\..\..\..\Mods
) else (
    if exist "%userprofile%\AppData\Roaming\Hytale\UserData\Mods\" (
        del "%userprofile%\AppData\Roaming\Hytale\UserData\Mods\A5TR0spud.Flamethrowers*.zip" /q
        copy "builds\A5TR0spud.Flamethrowers-!v!.zip" %userprofile%\AppData\Roaming\Hytale\UserData\Mods
    )
)
endlocal