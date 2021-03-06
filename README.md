# Change-Wallpaper
## I) Requirements
The scripts in this repo can be leveraged to changed wallpaper daily on a Windows 10 machine. To run the scripts, it is assumed that the user has the following installed:
1. WSL enabled on Windows Link [here](https://www.windowscentral.com/install-windows-subsystem-linux-windows-10).
2. sudo apt-get install -y xdg-utils on Windows Terminal

I could have made a single PowerShell script for generating as well as applying the wallpaper but I don't have sufficient experience in PowerShell (The limited script I've written currently is a result of googling and putting together code by observing the outputs!😅)

## II) Explainer into the repo structure
1. The `Wallpapers` directory for holding the wallpapers on which the script will work upon. You can add/remove wallpapers here.
2. `Cycle.sh` generates the new wallpaper to be displayed and stores the result in `curr_wallpaper.txt`. As a failsafe, the wallpaper is also displayed in a separate window for applying the wallpaper manually in case the powershell script fails to apply the wallpaper (observed to be erratic....working on a fix)  
3. `curr_wallpaper.txt` holds the name (and relative preprocessed path) for the current wallpaper.
4. `change_wallpaper.ps1` for reading the wallpaper to be displayed and finally applying the wallpaper.

## III) Task Scheduler for triggering scripts daily
Task scheduler can be used to create a task for triggering the script (powershell obviously!) daily. The powershell calls and runs the bash script for generating a suitable wallpaper for the day and then applies the wallpaper.<br>
To create a task, press Win+S -> Task Scheduler<br>
Here create a new folder (say MyTasks) and Create a Basic Task. Populate the fields as follows:-<br>
Name: Change Wallpaper<br>
Description: Script to change wallpaper daily<br>
Begin the Task: On a schedule<br>
Recur daily and set the time when you wish to trigger the task<br>
Action: Start a program<br>
Program/Script: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe (this can vary across systems. try locating your powershell.exe (`find . -name powershell.exe` in Windows Terminal))<br>
Add arguments(optional): -executionpolicy unrestricted -command C:\Users\sangh\Desktop\Projects\Cycle_Wallpaper\change_wallpaper.ps1 (or wherever your directory resides; add `-NoExit` before `-executionpolicy` in case the powershell terminates without any change!)<br>
