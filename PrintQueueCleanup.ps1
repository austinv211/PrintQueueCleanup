<#
NAME: PrintQueueCleanup.ps1
Description: Cleans up decommissioned printer queues from workstations
Author: Austin Vargason
Date Modified: 11/14/18
#>

#function to delete a list of print queues from a workstation
function Delete-PrintQueues() {

    param (
        [Parameter(Mandatory=$true)]
        [string[]]$QueueList
    )

    #get all the network printers on the system
    $networkPrinters = Get-WmiObject -Class Win32_Printer | where{$_.Network -eq $true}


    #loop through the list of printers and if the name exists in the list, delete it
    foreach ($printer in $networkPrinters) {
        if ($QueueList -contains $printer.ShareName) {

            $printer.delete()

        }
    }
}


Delete-PrintQueues -QueueList (Get-Content .\oldPrintQueues.txt)