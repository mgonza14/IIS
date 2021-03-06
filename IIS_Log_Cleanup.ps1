<#
.AUTHOR
    File Name:  IIS Log Cleanup.ps1
    Author:     Miguel Gonzalez
    Sources:    http://mmman.itgroove.net/2012/05/powershell-script-to-log-to-event-viewer-and-reboot/

.SYNOPSIS
This powershell script will: 
    1. State how many days back to delete files
    2. identify how many log files to delete and their size
    3. Delete the files 
    4. Count how many files will be deleted
    5. Get file sizes of deleted files and convert size to MBytes to 2 decimal places
    6. Create a entry in the event log to state how many and how big the deletion was 
#>

#1. State how many days back to delete files
$DaysOldtoDelete=180

#2. Identify how many log files to delete and their size
$DeletedFiles=0
$DeletedFiles = get-childitem -Path "C:\inetpub\logs\LogFiles" -recurse -force | where-object {$_.lastwritetime -lt (get-date).addDays(-$DaysOldtoDelete)}

#3. Delete the files 
$DeletedFiles | Foreach-Object { del $_.FullName }

#4. Count how many files will be deleted
$Count     = $DeletedFiles.count

#5. Get file sizes of deleted files and convert size to MBytes to 2 decimal places
$FileSizes = $DeletedFiles | Measure-Object -Sum Length
$SizeinMB  = $FileSizes.sum/1MB
$SizeinMB  = "{0:N2}" -f $SizeinMB

#6. Create a entry in the event log to state how many and how big the deletion was 
$evt=new-object System.Diagnostics.EventLog("Application") 
$evt.Source="Clear IIS Log Files" 
$infoevent=[System.Diagnostics.EventLogEntryType]::Information 
$vdate=Get-Date 
$val="The scheduled task 'IIS Log Cleanup.ps1' has finished. ["+$Count+"] IIS log files totaling "+$SizeinMB+"MB have been deleted." 
$evt.WriteEntry($val,$infoevent,1337) 