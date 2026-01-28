# Flamethrowers

This is my attempt to add flamethrowers to Hytale without any dependencies or code. Everything was made with the asset editor and accompanying software.

The build.bat is a helper file/dev tool and should be ***IGNORED BY NORMAL USERS.*** It will create a new zip file for the mod's current version in a folder called "builds." It changes the mod id from "FlamethrowersIndev" to just "Flamethrowers." It then copies said zip file into the mods folder of your Hytale installation, deleting any extraneous versions. It only works if your Hytale installation is in \<user\>/AppData/Roaming/Hytale OR if the build.bat is in a .../Hytale/UserData/Saves/\<world\>/mods folder. Additionally, it requires Windows Powershell (which should come with any (modern) Windows device). Apologies to users of other OS's.
