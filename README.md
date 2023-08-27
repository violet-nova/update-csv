# update-csv

Re-opening Excel every time you want to make a small update to a spreadsheet can be annoying. I wrote this script while job-searching in order so that I could quickly update my tracker from the command line in Windows 10.

By default, this script assumes you placed "position" and "employer" in the first two columns, and date of last correspondence in the fifth column. All three can be easily tweaked in the beginning.

To run from Powershell, enter `Rscript update-app-tracker arg1 arg2 ...`

If the Rscript command is not recognized, **make sure it's added to your environment variables:**
* Open Control Panel > System and Security > System > Click Advanced System Settings > Environment Variables
* In the lower box (System variables) scroll down and double click "Path" to pull up "Edit environment variable"
* Click "New" and enter the path to "bin" of the current version of R you have installed. e.g. "C:\path\path\R\R-4.2.2\bin"
* Close and re-open Powershell. If it still does not work, try Restarting R, or your PC. 
