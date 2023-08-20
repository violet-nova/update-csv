# update-csv

Re-opening Excel every time you want to make a small update to a spreadsheet can be annoying. I wrote this script while job-searching in order so that I could quickly update my tracker from the command line.

By default, this script assumes you placed "position" and "employer" in the first two columns, and date of last correspondence in the fifth column. All three can be easily tweaked in the beginning.

To run from Powershell, enter `Rscript update-app-tracker arg1 arg2 ...`

If the Rscript command is not recognized, [make sure it's added to your environment variables]([url](https://stackoverflow.com/a/42567862)https://stackoverflow.com/a/42567862).
