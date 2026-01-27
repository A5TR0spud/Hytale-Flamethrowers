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
xcopy "Server" "builds\Server\" /E
xcopy "Common" "builds\Common\" /E
del "builds\A5TR0spud.Flamethrowers-!v!.zip" /Q
powershell -Command "Compress-Archive -Path 'builds\*' -DestinationPath 'builds\A5TR0spud.Flamethrowers-!v!.zip'"
rmdir "builds\Server" /S /Q
rmdir "builds\Common" /S /Q
del "builds\manifest.json" /Q
endlocal