@echo off
SETLOCAL EnableDelayedExpansion
rmdir "release" /S /Q
mkdir "release"
> "release\manifest.json" (
    FOR /f "delims=*" %%a IN (manifest.json) DO (
        set b=%%a
        echo !b:Indev=!
    )
)
xcopy "Server" "release\Server\" /E
xcopy "Common" "release\Common\" /E
powershell -Command "Compress-Archive -Path 'release\*' -DestinationPath 'release\A5TR0spud.Flamethrowers.zip'"
rmdir "release\Server" /S /Q
rmdir "release\Common" /S /Q
del "release\manifest.json" /S /Q
endlocal