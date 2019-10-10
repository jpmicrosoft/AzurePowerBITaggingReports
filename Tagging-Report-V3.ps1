#############################################################################################
######################## This script was created by Ernest Oshokoya  ########################
######################## This is his github https://github.com/eosho ########################
######################## I simply modified it to suit my needs.      ########################
########################        Thank you Ernest!                    ########################
#############################################################################################

# Requires Az Module https://aka.ms/az270
# Install-Module -Name Az


# Requires ImportExcel Module https://aka.ms/importexcel542
# Install-Module -Name ImportExcel -RequiredVersion 5.4.2 

Import-Module ImportExcel

function Set-AzureLogin {
    
    $needLogin = $true
    Try {
        $content = Get-AzContext
        echo $content
        if ($content) {
            $needLogin = ([string]::IsNullOrEmpty($content.Account))
        } 
    } 
    Catch {
        if ($_ -like "*Login-AzAccount to login*") {
            $needLogin = $true
        } 
        else {
            throw
        }
    }

    if ($needLogin) {        
        # Ensure to set the -Environment AzureCloud for commercial or AzureUSGovernment, etc. https://aka.ms/azenv       
        Connect-AzAccount -Environment AzureCloud
    }
}

function Get-FileName ([String]$Report_Name) {    
    
    $file_path = "c:\temp\"
    $date = Get-Date -UFormat "%Y%m%d"    
    
    $file_path = "C:\temp\AzureReports\"
    $file_name = $file_path + $Report_Name + ".xlsx"
    if (-Not(Test-Path $file_path -PathType Container)) {
        new-item $file_path -ItemType directory -Force
    }
    if (Test-Path $file_name -PathType Leaf) {
        remove-item $file_name -Force
    }
    Set-Location -Path $file_path

    return $file_name
}

# Create Folders

Get-FileName

function Invoke-AzureSubscriptionLoop {
    
    Set-AzureLogin

    # Fetch current working directory 
    $Report_Name = Get-FileName -Report_Name "AzureTagsReport"

    # Fetching subscription list
    $subscription_list = Get-AzSubscription 
    $Azure_Tags = @()
    
    # Fetching the IaaS inventory list for each subscription
    foreach ($subscription_list_iterator in $subscription_list) {

        echo $subscription_list_iterator.Name

        try {

            #Selecting the Azure Subscription
            Select-AzSubscription -SubscriptionName $subscription_list_iterator.Name

            $resource_groups = Get-AzResourceGroup
            $export_array = $null
            $export_array = @()
            #Iterate through resource groups
            foreach ($resource_group_iterator in $resource_groups) {
                
                #Get Resource Group Tags
                $rg_tags = (Get-AzResourceGroup -Name $resource_group_iterator.ResourceGroupName)
                $Tags = $rg_tags.Tags
                #Checking if tags is null or has value
                if ($Tags -ne $null) {
                    
                    $Tags.GetEnumerator() | % { 
                        $details = @{            
                            ResourceId        = $resource_group_iterator.ResourceId
                            Name              = $resource_group_iterator.ResourceGroupName
                            ResourceType      = "Resource-Group"
                            ResourceGroupName = $resource_group_iterator.ResourceGroupName
                            Location          = $resource_group_iterator.Location
                            SubscriptionName  = $subscription_List_Iterator.Name 
                            Tag_Key           = $_.Key
                            Tag_Value         = $_.Value
                        }
                        $export_array += New-Object PSObject -Property $details
                    }
                                        

                }
                else {

                    $TagsAsString = "NULL"
                    $details = @{            
                        ResourceId        = $resource_group_iterator.ResourceId
                        Name              = $resource_group_iterator.ResourceGroupName
                        ResourceType      = "Resource-Group"
                        ResourceGroupName = $resource_group_iterator.ResourceGroupName
                        Location          = $resource_group_iterator.Location
                        SubscriptionName  = $subscription_List_Iterator.Name 
                        Tag_Key           = "NULL"
                        Tag_Value         = "NULL"
                    }                           
                    $export_array += New-Object PSObject -Property $details 
                }
            }

            #Getting all Azure Resources
            $resource_list = Get-AzResource
            
            #Declaring Variables
            $TagsAsString = ""

            foreach ($resource in $resource_list) {
               
                #Fetching Tags
                $Tags = $resource.Tags
    
                #Checking if tags is null or has value
                if ($Tags -ne $null) {
                    
                    $Tags.GetEnumerator() | % { 
                        $details = @{            
                            ResourceId        = $resource.ResourceId
                            Name              = $resource.Name
                            ResourceType      = $resource.ResourceType
                            ResourceGroupName = $resource.ResourceGroupName
                            Location          = $resource.Location
                            SubscriptionName  = $subscription_List_Iterator.Name 
                            Tag_Key           = $_.Key
                            Tag_Value         = $_.Value
                        }
                        $export_array += New-Object PSObject -Property $details
                    }
                                        

                }
                else {

                    $TagsAsString = "NULL"
                    $details = @{            
                        ResourceId        = $resource.ResourceId
                        Name              = $resource.Name
                        ResourceType      = $resource.ResourceType
                        ResourceGroupName = $resource.ResourceGroupName
                        Location          = $resource.Location
                        SubscriptionName  = $subscription_List_Iterator.Name 
                        Tag_Key           = "NULL"
                        Tag_Value         = "NULL"
                    }                           
                    $export_array += New-Object PSObject -Property $details 
                }
            }

            #Generating Output
            $echo = "Writing to: " + $Report_Name
            echo $echo
            $Azure_Tags += $export_array
            
        }
        catch [system.exception] {

            Write-Output "Error in generating report: $($_.Exception.Message) "
            Write-Output "Error Details are: "
            Write-Output $Error[0].ToString()
            Exit $ERRORLEVEL
        }
    }     

    $Azure_Tags | Export-Excel $Report_Name -AutoSize -AutoFilter
}

Invoke-AzureSubscriptionLoop