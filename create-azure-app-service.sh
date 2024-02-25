#!/bin/bash

# Azure configuration
resourceGroupName="simons-example-resource-group"
appServiceName="simons-example-app-service"
location="UK South"
servicePlanSku="F1"  # Free pricing tier

# Log in to Azure
az login

# Check if the resource group already exists
if az group show --name $resourceGroupName --query "name" --output tsv 2>/dev/null; then
    echo "Resource group '$resourceGroupName' already exists."
else
    # Create the resource group
    az group create --name $resourceGroupName --location "$location"
    echo "Resource group '$resourceGroupName' created."
fi

# Check if the service plan already exists
if az appservice plan show --name $appServiceName-Plan --resource-group $resourceGroupName --query "name" --output tsv 2>/dev/null; then
    echo "App Service Plan '$appServiceName-Plan' already exists."
else
    # Create the App Service Plan
    az appservice plan create --name $appServiceName-Plan --resource-group $resourceGroupName --sku $servicePlanSku
    echo "App Service Plan '$appServiceName-Plan' created."
fi

# Create the App Service
az webapp create --name $appServiceName --resource-group $resourceGroupName --plan $appServiceName-Plan

echo "App Service '$appServiceName' created in resource group '$resourceGroupName' in location '$location'."
