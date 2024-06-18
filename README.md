

# Magnet AXIOM on ARM
This is a guide to installing and running Magnet AXIOM on Windows ARM architecture, eg to run on an ARM Mac in VMWare Fusion.

The vanilla AXIOM installer will in fact complete, but upon running the program will come up with an "**unrecoverable error**".

This is because AXIOM requires certain Visual C++ libraries but Magnet's installer does not support ARM architecture, and therefore does not include ARM versions of these libraries, therefore they must be installed manually. See [Microsoft's Visual C++ Redistributable page](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170#visual-studio-2015-2017-2019-and-2022) for further details.

My successful installation is based on the following hardware and software:
- MacBook Pro 16" 2021 (Apple M1 Max)
- MacOS Sonoma 14.5
- VMWare Fusion 13.5.1, running:
  - Win 11 Enterprise 23H2
  - 48GB RAM
  - Installed using VMWare's "Get Windows From Microsoft" option

## Install fresh AXIOM (version 8 or above)

1) Download the **Full Installer** from Magnet's [Software & Downloads](https://support.magnetforensics.com/s/magnet-axiom/axiom-software-and-downloads) page (Magnet login required).
2) Install as normal but **do not run yet**
3) Download the [Visual C++ Redistributable installer **for ARM64**](https://aka.ms/vs/17/release/vc_redist.arm64.exe) from Microsoft
4) Install the C++ Redistributable.
5) You also need the [**.NET Framework 4.8.1**](https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net481-web-installer), though it *might* be installed on your system already.
6) Install the downloaded executable (the installation will halt if the current or a newer version is already installed).
7) Reboot
8) Open AXIOM and enjoy!

If you plan on updating your ARM installation of AXIOM in the future, please consider following the update instrutctions **from step 5** below which will prevent future updating problems.

## Upgrade AXIOM (eg 8.0 to 8.2)

1) Download and run the **Upgrade installer** from Magnet's [Software & Downloads](https://support.magnetforensics.com/s/magnet-axiom/axiom-software-and-downloads) page (Magnet login required)
2) Open the installer but **do not rush to click through**!
3) Select your language and accept the EULA.
4) You will then be asked where to unpack the installer to. The default location is fine, but you must choose an existing installation of AXIOM.
5) Navigate to the existing installation in Explorer (```C:\Program Files\Magnet Forensics\Magnet AXIOM``` by default) and locate the ```\prerequisites``` directory.
6) Locate the ```a_postupdate.bat``` file and open it in a text editor
7) This file checks for existing installations of Visual C++ Redistributable and installs them if not found. But this does not cater for ARM architectures, so the checks must be skipped. You can edit this manually, or download a complete edited version [here](a_postupdate.bat) and replace your existing script.

>### Editing the ```a_postupdate.bat``` file:
>Open the file using administrator privileges in a text editor. The first three lines are as follows:
>```
>pushd "%~dp0\\.."
>    pushd "prerequisites"
>        :: ERRORLEVEL codes can be found here: https://docs.microsoft.com/en-us/windows/win32/msi/error-codes
>```
>Add a new line after this and type:
>```goto skipCheck```
>
>Then locate the following lines further down (approx line 28):
>```
>echo "Calling Compare-ComponentManifest.ps1 from a_postupdate.bat" > .\Compare-ComponentManifest.log
>powershell -ExecutionPolicy Bypass -File .\Compare-ComponentManifest.ps1 -ProductPath ..\ -ManifestPath .\manifest.xml -Clean -LogOutput
>```
>Insert a line **just above** these two lines and type:
>```:skipCheck```
>There *MUST* be a colon at the start of the line!
>
>Save the file. Now the checks will be skipped and the installer will continue to the end!

8) Continue the installer to its conclusion. If an error shows up with an exit code **1** or **2**, just run the upgrade installer again from the start.



# Magnet AXIOM on ARM
This is a guide to installing and running Magnet AXIOM on Windows ARM architecture, eg to run on an ARM Mac in VMWare Fusion.

The vanilla AXIOM installer will in fact complete, but upon running the program will come up with an "**unrecoverable error**".

This is because AXIOM requires certain Visual C++ libraries but Magnet's installer does not support ARM architecture, and therefore does not include ARM versions of these libraries, therefore they must be installed manually. See [Microsoft's Visual C++ Redistributable page](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170#visual-studio-2015-2017-2019-and-2022) for further details.

My successful installation is based on the following hardware and software:
- MacBook Pro 16" 2021 (Apple M1 Max)
- MacOS Sonoma 14.5
- VMWare Fusion 13.5.1, running:
  - Win 11 Enterprise 23H2
  - 48GB RAM
  - Installed using VMWare's "Get Windows From Microsoft" option

## Install fresh AXIOM (version 8 or above)

1) Download the **Full Installer** from Magnet's [Software & Downloads](https://support.magnetforensics.com/s/magnet-axiom/axiom-software-and-downloads) page (Magnet login required).
2) Install as normal but **do not run yet**
3) Download the [Visual C++ Redistributable installer **for ARM64**](https://aka.ms/vs/17/release/vc_redist.arm64.exe) from Microsoft
4) Install the C++ Redistributable.
5) You also need the [**.NET Framework 4.8.1**](https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net481-web-installer), though it *might* be installed on your system already.
6) Install the downloaded executable (the installation will halt if the current or a newer version is already installed).
7) Reboot
8) Open AXIOM and enjoy!

If you plan on updating your ARM installation of AXIOM in the future, please consider following the update instrutctions **from step 5** below which will prevent future updating problems.

## Upgrade AXIOM (eg 8.0 to 8.2)

1) Download and run the **Upgrade installer** from Magnet's [Software & Downloads](https://support.magnetforensics.com/s/magnet-axiom/axiom-software-and-downloads) page (Magnet login required)
2) Open the installer but **do not rush to click through**!
3) Select your language and accept the EULA.
4) You will then be asked where to unpack the installer to. The default location is fine, but you must choose an existing installation of AXIOM.
5) Navigate to the existing installation in Explorer (```C:\Program Files\Magnet Forensics\Magnet AXIOM``` by default) and locate the ```\prerequisites``` directory.
6) Locate the ```a_postupdate.bat``` file and open it in a text editor
7) This file checks for existing installations of Visual C++ Redistributable and installs them if not found. But this does not cater for ARM architectures, so the checks must be skipped. You can edit this manually, or download a complete edited version [here](a_postupdate.bat) and replace your existing script.

>### Editing the ```a_postupdate.bat``` file:
>Open the file using administrator privileges in a text editor. The first three lines are as follows:
>```
>pushd "%~dp0\\.."
>    pushd "prerequisites"
>        :: ERRORLEVEL codes can be found here: https://docs.microsoft.com/en-us/windows/win32/msi/error-codes
>```
>Add a new line after this and type: ```goto skipCheck```
>Then locate the following lines further down (approx line 28):
>```
>echo "Calling Compare-ComponentManifest.ps1 from a_postupdate.bat" > .\Compare-ComponentManifest.log
>powershell -ExecutionPolicy Bypass -File .\Compare-ComponentManifest.ps1 -ProductPath ..\ -ManifestPath .\manifest.xml -Clean -LogOutput
>```
>Insert a line **just above** these two lines and type:
>```:skipCheck```
>
>There *MUST* be a colon at the start of the line!
>
>Save the file. Now the checks will be skipped and the installer will continue to the end!

8) Continue the installer to its conclusion. If an error shows up with an exit code **1** or **2**, just run the upgrade installer again from the start.

