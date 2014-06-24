# AzureBackup.ps1
# dumps configuration from the Azure portal to a set of text files
# Andy Shoemaker, 6/16/2014

Get-Module -ListAvailable
# Remove restrictions
# Set-ExecutionPolicy Unrestricted

# Misc
$date = Get-Date
$enddate = (Get-Date).tostring("yyyyMMdd")
$dir = "C:\AzureBackup\"
$outfile = $dir + $enddate + '-All-azureinfo.txt'
$dirdate = $dir + $enddate

# Intro text
Write-Output "Gather Azure Environment Information - [ SnapShot taken on $date ]`r`nLogged as: $outfile`r`n" | Out-File $outfile 

# All information
Write-Output "~~~~~~~~~~~~~~~ Steward All ~~~~~~~~~~~~~~~~" | Out-File $outfile -append
Get-AzureSubscription | Out-File $outfile -append


# -------------------------------------- Test -------------------------------------- #

# Contents 
Write-Output "~~~~~~~~~~~~~~~ Steward Test ~~~~~~~~~~~~~~~~" | Out-File $outfile -append
Select-AzureSubscription -SubscriptionName "Steward Test Subscription"
Get-AzureVNetSite | Out-File $outfile -append

# List of virtual machines 
Write-Output "`r`nList of Virtual Machines" | Out-File $outfile -append
Get-AzureVM | Out-File $outfile -append

## Tuple workaround
# Get the servicenames and servernames
$all=Get-AzureVM | select ServiceName, Name
# Additional VM information
Write-Output "`r`nFull VM Information" | Out-File $outfile -append
for($i=0; $i -lt $all.Count; $i++)
{
    $sname = $all[$i].ServiceName
    $hname = $all[$i].Name
    Get-azurevm $sname -name "$hname" | Out-File $outfile -append
    Write-Output "`r`n" | Out-File $outfile -append 
}

# Storage 
Write-Output "Storage Configuration" | Out-File $outfile -append
Get-AzureStorageAccount | Out-File $outfile -append

# Show all disk information 
Write-Output "`r`nDisks" | Out-File $outfile -append
Get-AzureDisk | Out-File $outfile -append

# Network 
Write-Output "Network Settings" | Out-File $outfile -append
Write-Output "`r`nComplete VNET Config written to $dirdate-Test-vnetcfg.xml" | Out-File $outfile -append
Get-AzureVNetConfig -ExportToFile $dirdate-Test-vnetcfg.xml

# Endpoint Information
Write-Output "`r`nEndpoint Information" | Out-File $outfile -append
for($i=0; $i -lt $all.Count; $i++)
{
    $sname = $all[$i].ServiceName
    $hname = $all[$i].Name
    Write-Output "~~~~~~ $hname endpoints ~~~~~~" | Out-File $outfile -append
    $endpoints = Get-azurevm "$sname" -name "$hname" | Get-AzureEndpoint 
    Get-azurevm "$sname" -name "$hname" | Get-AzureEndpoint  | Out-File $outfile -append
    ForEach($end in $endpoints.Name)
    {
        Write-Output "`r`n~~~~~~ $end ~~~~~~`r`n" | Out-File $outfile -append 
        Get-azurevm $sname -name "$hname" | Get-AzureAclConfig -EndpointName "$end" | Out-File $outfile -append

    }
}

# -------------------------------------- Dev -------------------------------------- #

# Contents 
Write-Output "~~~~~~~~~~~~~~~ Steward Development ~~~~~~~~~~~~~~~~" | Out-File $outfile -append
Select-AzureSubscription -SubscriptionName "Steward Development Subscription"
Get-AzureVNetSite | Out-File $outfile -append

# List of virtual machines 
Write-Output "`r`nList of Virtual Machines" | Out-File $outfile -append
Get-AzureVM | Out-File $outfile -append

## Tuple workaround
# Get the servicenames and servernames
$all=Get-AzureVM | select ServiceName, Name
# Additional VM information
Write-Output "`r`nFull VM Information" | Out-File $outfile -append
for($i=0; $i -lt $all.Count; $i++)
{
    $sname = $all[$i].ServiceName
    $hname = $all[$i].Name
    Get-azurevm $sname -name "$hname" | Out-File $outfile -append
    Write-Output "`r`n" | Out-File $outfile -append 
}

# Storage 
Write-Output "Storage Configuration" | Out-File $outfile -append
Get-AzureStorageAccount | Out-File $outfile -append

## ** Need to provide certificate - tried numerous things but could not make this pass
# Show all recovery vaults 
# Write-Output "Recovery Vaults" | Out-File $outfile -append
# Get-OBRecoveryService | Out-File $outfile -append 

# Show all disk information 
Write-Output "`r`nDisks" | Out-File $outfile -append
Get-AzureDisk | Out-File $outfile -append

# Network 
Write-Output "Network Settings" | Out-File $outfile -append
Write-Output "`r`nComplete VNET Config written to $dirdate-Dev-vnetcfg.xml" | Out-File $outfile -append
Get-AzureVNetConfig -ExportToFile $dirdate-Dev-vnetcfg.xml

# Endpoint Information
Write-Output "`r`nEndpoint Information" | Out-File $outfile -append
for($i=0; $i -lt $all.Count; $i++)
{
    $sname = $all[$i].ServiceName
    $hname = $all[$i].Name
    Write-Output "~~~~~~ $hname endpoints ~~~~~~" | Out-File $outfile -append
    $endpoints = Get-azurevm "$sname" -name "$hname" | Get-AzureEndpoint 
    Get-azurevm "$sname" -name "$hname" | Get-AzureEndpoint  | Out-File $outfile -append
    ForEach($end in $endpoints.Name)
    {
        Write-Output "`r`n~~~~~~ $end ~~~~~~`r`n" | Out-File $outfile -append 
        Get-azurevm $sname -name "$hname" | Get-AzureAclConfig -EndpointName "$end" | Out-File $outfile -append

    }
}

# -------------------------------------- Production -------------------------------------- #

# Contents 
Write-Output "~~~~~~~~~~~~~~~ Steward Production ~~~~~~~~~~~~~~~~" | Out-File $outfile -append
Select-AzureSubscription -SubscriptionName "Steward Production Subscription"
Get-AzureVNetSite | Out-File $outfile -append

# List of virtual machines 
Write-Output "`r`nList of Virtual Machines" | Out-File $outfile -append
Get-AzureVM | Out-File $outfile -append

## Tuple workaround
# Get the servicenames and servernames
$all=Get-AzureVM | select ServiceName, Name
# Additional VM information
Write-Output "`r`nFull VM Information" | Out-File $outfile -append
for($i=0; $i -lt $all.Count; $i++)
{
    $sname = $all[$i].ServiceName
    $hname = $all[$i].Name
    Get-azurevm $sname -name "$hname" | Out-File $outfile -append
    Write-Output "`r`n" | Out-File $outfile -append 
}

# Storage 
Write-Output "Storage Configuration" | Out-File $outfile -append
Get-AzureStorageAccount | Out-File $outfile -append

## ** Need to provide certificate - tried numerous things but could not make this pass
# Show all recovery vaults 
# Write-Output "Recovery Vaults" | Out-File $outfile -append
# Get-OBRecoveryService | Out-File $outfile -append 

# Show all disk information 
Write-Output "`r`nDisks" | Out-File $outfile -append
Get-AzureDisk | Out-File $outfile -append

# Network 
Write-Output "Network Settings" | Out-File $outfile -append
Write-Output "`r`nComplete VNET Config written to $dirdate-Prod-vnetcfg.xml" | Out-File $outfile -append
# NOTE: This export can be re-imported from the Azure console -- Networks / New / Import Configuration
Get-AzureVNetConfig -ExportToFile $dirdate-Prod-vnetcfg.xml

# Endpoint Information
Write-Output "`r`nEndpoint Information" | Out-File $outfile -append
for($i=0; $i -lt $all.Count; $i++)
{
    $sname = $all[$i].ServiceName
    $hname = $all[$i].Name
    Write-Output "~~~~~~ $hname endpoints ~~~~~~" | Out-File $outfile -append
    $endpoints = Get-azurevm "$sname" -name "$hname" | Get-AzureEndpoint 
    Get-azurevm "$sname" -name "$hname" | Get-AzureEndpoint  | Out-File $outfile -append
    ForEach($end in $endpoints.Name)
    {
        Write-Output "`r`n~~~~~~ $end ~~~~~~`r`n" | Out-File $outfile -append 
        Get-azurevm $sname -name "$hname" | Get-AzureAclConfig -EndpointName "$end" | Out-File $outfile -append

    }
}

# New-Tuple code 
# Will use in future 
function New-Tuple()
{
    param ( [object[]]$list= $(throw "Please specify the list of names and values") )

    $tuple = new-object psobject
    for ( $i= 0 ; $i -lt $list.Length; $i = $i+2)
    {
        $name = [string]($list[$i])
        $value = $list[$i+1]
        $tuple | add-member NoteProperty $name $value
    }
    return $tuple
}

# Reapply restrictions
Set-ExecutionPolicy RemoteSigned