pushd "%~dp0\\.."
    pushd "prerequisites"
        :: ERRORLEVEL codes can be found here: https://docs.microsoft.com/en-us/windows/win32/msi/error-codes
        
    		goto skip
    		::Bypass the .NET 4.8.1 / C++ installation as it will not install for ARM architecture
    		:: and needs to be preinstalled manually
    		
    		1_ndp48-x86-x64-allos-enu.exe /passive /norestart
        set /A RESULT=%ERRORLEVEL%
        set res=F
        if %RESULT% == 0 set res=T
        if %RESULT% == 1641 set res=T
        if %RESULT% == 3010 set res=T
        if '%res%' == 'T' (
            echo "Successful .net48 install"
        ) else (
            exit /B 1
        )
		
        a_vcredist_x64_2015_2019.exe /passive /norestart
        set /A RESULT=%ERRORLEVEL%
        set res=F
        if %RESULT% == 0 set res=T
        if %RESULT% == 1638 set res=T
        if %RESULT% == 3010 set res=T
        if '%res%' == 'T' (
            echo "Successful vcredist2015x64 install"
        ) else (
            exit /B 2
        )
		
    		:skip
    		echo "Skipped installation of vcredis due to ARM architecture - make sure this is manually installed!"
		
        echo "Calling Compare-ComponentManifest.ps1 from a_postupdate.bat" > .\Compare-ComponentManifest.log
        powershell -ExecutionPolicy Bypass -File .\Compare-ComponentManifest.ps1 -ProductPath ..\ -ManifestPath .\manifest.xml -Clean -LogOutput
        set /A RESULT=%ERRORLEVEL%
        echo "Compare-ComponentManifest exit with code %RESULT%"

        ECHO "Call Invoke-Shell32ShChangeNotify"
        powershell -ExecutionPolicy Bypass -File .\Invoke-Shell32ShChangeNotify.ps1
        SET /A RESULT=%ERRORLEVEL%
        ECHO "Invoke-Shell32ShChangeNotify exit with code %RESULT%"

        call b_launch_product.bat
    popd
popd

exit /B 0
