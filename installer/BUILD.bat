@echo off

set OSG=D:\dev\Installs\OpenSceneGraph-3.4.0\vs2010\x64\bin
set OSG_DEPS=D:\dev\3rdParty\vs2010\x64\bin
set OSGEARTH=D:\dev\Installs\OSGEARTH\OpenSceneGraph-3.4.0\vs2010\x64\bin
set OSG_PLUGINS_FOLDER=osgPlugins-3.4.0
set OSGEARTH_PLUGINS=%OSGEARTH%\%OSG_PLUGINS_FOLDER%
set OSG_PLUGINS_DIR=%OSG%\%OSG_PLUGINS_FOLDER%
set GEOS=D:\dev\geos-3.2.2_dist\vs2010\x64\bin
set SQLITE=D:\dev\sqlite3\vs2010\x64\bin
set CEF=D:\dev\cef_binary_3.2272.32.gbda8dc7_windows64\Release
set CEF_RESOURCES=D:\dev\cef_binary_3.2272.32.gbda8dc7_windows64\Resources
set GDAL=D:\dev\gdal\release-1600-x64\bin
set SIMDIS=D:\dev\Installs\SIMDIS_SDK\bin

set BUILD_DIR=build

REM Delete the output directory if it exists
RD /S /Q %BUILD_DIR%

REM Create the build dir 
mkdir %BUILD_DIR%

REM Copy the OSG dlls 
xcopy /D /Y "%OSG%\*.dll" %BUILD_DIR%

REM Copy the OSG earth dlls 
xcopy /D /Y "%OSGEARTH%\*.dll" %BUILD_DIR%

REM Copy OSG deps
xcopy /D /Y "%OSG_DEPS%\*.dll" %BUILD_DIR%

REM Copy GDAL deps
xcopy /S /D /Y "%GDAL%" %BUILD_DIR%

REM Copy over the necessary plugins
mkdir "%BUILD_DIR%\%OSG_PLUGINS_FOLDER%"

REM Copy over the simdis dlls
xcopy /D /Y "%SIMDIS%\*.dll" %BUILD_DIR%

xcopy /D /Y "%OSG_PLUGINS_DIR%\osgdb_*.dll" "%BUILD_DIR%\%OSG_PLUGINS_FOLDER%"

xcopy /D /Y "%OSGEARTH_PLUGINS%\*.dll" "%BUILD_DIR%\%OSG_PLUGINS_FOLDER%"

REM Copy over the GEOS dlls
xcopy /D /Y "%GEOS%\*.dll" %BUILD_DIR%

REM Copy over the SQLite dlls
xcopy /D /Y "%SQLITE%\*.dll" %BUILD_DIR%

REM Copy over CEF
xcopy /S /D /Y "%CEF%" %BUILD_DIR%

REM Copy over CEF resources
xcopy /S /D /Y "%CEF_RESOURCES%" %BUILD_DIR%

REM Copy over the Packager application
xcopy /S /D /Y "..\applications\packager" %BUILD_DIR%

REM Copy over osgearth_cef and rename it packager.exe
set CEF_EXE=%CD%\..\bin\x64\release\osgearth_cef.exe
copy %CEF_EXE% %BUILD_DIR%\packager.exe

REM Delete any debug dlls
del %BUILD_DIR%\*d.dll
del %BUILD_DIR%\%OSG_PLUGINS_FOLDER%\*d.dll

REM Actually build the installer
compil32 /cc packager.iss