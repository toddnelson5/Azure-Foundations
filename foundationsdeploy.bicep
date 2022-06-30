targetScope = 'subscription'

@description('resource group name')
param resourceGroupName string = 'rg_services_foundations'

@description('Resource group location')
param location string = 'East US'

@description('resource tags for deployed resources')
param resourceTags object = {
  Environment: 'Services'
  Created_By: 'Airnet'
}

resource serviceRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: resourceTags
  properties:{
    
  }
}

module storagedeploy 'servicesdeploy.bicep' ={ 
scope: resourceGroup(serviceRG.name)
  name: 'servicesdeployment-${uniqueString(serviceRG.id)}'
}
