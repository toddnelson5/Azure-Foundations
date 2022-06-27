targetScope = 'subscription'

@description('resource group name')
param resourceGroupName string = 'rg_services_foundations'

@description('Resource group location')
param location string = 'East US'

resource serviceRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  properties: {
    
  }
}

module servicesDeploy 'servicesnoGWdeploy.bicep' = {
  scope: serviceRG 
  name: servicesEnvironment
}
