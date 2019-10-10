# Azure Power BI Tagging Reports

## Overview
This solution extracts tagging from all of the subscriptions of which the user who runs the scripts has access to. It exports the data to an Excel file. Power BI Desktop is used to provide several visualizations.  There are four reports, each with four additional variations of each report. The variation being the primary visualization.

*Resources without tags are represented with a NULL value.

## Prerequisites 

### PowerShell

###### PowerShell version 5.1
###### Azure [Az Module](https://aka.ms/az270)
###### [ImportExcel Module](https://aka.ms/importexcel542) 

### Power BI Desktop 

##### [Word Cloud](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA104380752?tab=Overview)
##### [Bubble Chart by Akvelon](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA104381340?tab=Overview) (using the free version)

A special thanks to [Ernest Oshokoya](https://github.com/eosho) for providing the original script!
