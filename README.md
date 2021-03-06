# Azure Power BI Tagging Reports

## Overview
This solution extracts tagging from all the subscriptions of which the user who runs the scripts has access to. It exports the data to an Excel file. Power BI Desktop is used to provide several visualizations.  There are four reports, each with four additional variations of each report. The variation being the primary visualization.

*Resources without tags are represented with a NULL value.

## Prerequisites 
Please ensure that you have PowerShell 5.1 and the modules listed below installed.

*Please ensure that you change the environment variable in the script if you are not using Azure Commercial. 
### PowerShell

###### PowerShell version 5.1
###### Install Azure [Az Module](https://aka.ms/az270)
###### Install [ImportExcel Module](https://aka.ms/importexcel542) 

### Power BI Desktop 
Please ensure that you have Power BI Desktop and the visualization listed installed.

##### Install [Power BI Desktop](https://aka.ms/powerbinow)
#### [How to add visualizations from the marketplace?](https://docs.microsoft.com/en-us/power-bi/power-bi-custom-visuals#download-or-import-power-bi-visuals-from-microsoft-appsource)
##### Add [Word Cloud](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA104380752?tab=Overview)
##### Add [Bubble Chart by Akvelon](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA104381340?tab=Overview) (using the free version)

## Instructions
Ensure the prerequisites have been completed.
1. Open PowerShell as administrator
2. Run the Tagging-Report-V3.ps1
3. Navigate to the path were the file was exported and confirm that it exist and that you see data.
4. Open Azure Tagging Reports.pbix file in PowerBI Desktop. If you kept the path and folders with the default settings, the reports will populated automatically.

## Sample Reports
### Sample Report 1

![Sample Report 1](https://github.com/jpmicrosoft/AzurePowerBITaggingReports/raw/master/Report1.jpg "Sample Report 1")

### Sample Report 2

![Sample Report 2](https://github.com/jpmicrosoft/AzurePowerBITaggingReports/raw/master/Report2.jpg "Sample Report 2")

### Sample Report 3

![Sample Report 3](https://github.com/jpmicrosoft/AzurePowerBITaggingReports/raw/master/Report3.jpg "Sample Report 3")

### Sample Report 4

![Sample Report 4](https://github.com/jpmicrosoft/AzurePowerBITaggingReports/raw/master/Report4.jpg "Sample Report 4")

A special thanks to [Ernest Oshokoya](https://github.com/eosho) for providing the original PowerShell script!
