targetScope = 'subscription'

@description('services resource group name')
param resourceGroupName string = 'rg_bicep_deployment'

@description('production resource group name')
param prodGroupName string = 'rg_prod_deployment'

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

resource productionRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: prodGroupName
  location: location
  tags: resourceTags
  properties:{
    
  }
}

module foundationsdeploy servicesnoGWdeploy.bicep ={ 
scope: resourceGroup(serviceRG.name)
  name: 'servicesdeployment-${uniqueString(serviceRG.id)}'

}

module proddeploy proddeploy.bicep = {
scope: resourceGroup(prodRG.name)
  name: 'productiondeploymnet-${uniqueString(prodRG.id)}'
  
}
