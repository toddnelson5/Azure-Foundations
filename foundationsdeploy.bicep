targetScope = 'subscription'

@description('services resource group name')
param servicesGroupName string = 'rg_services_deployment'

@description('production resource group name')
param productionGroupName string = 'rg_production_deployment'

@description('Resource group location')
param location string = 'East US'

@description('resource tags for deployed resources')
param resourceTags object = {
  Environment: 'Services'
  Created_By: 'Airnet'
}

@description('Set the local VNet name')
param existingLocalVirtualNetworkName string

@description('Set the remote VNet name')
param existingRemoteVirtualNetworkName string

@description('Sets the remote VNet Resource group')
param existingRemoteVirtualNetworkResourceGroupName string


resource serviceRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: servicesGroupName
  location: location
  tags: resourceTags
  properties:{
    
  }
}

resource productionRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: productionGroupName
  location: location
  tags: resourceTags
  properties:{
    
  }
}

module servicesdeploy 'servicesnoGWdeploy.bicep' ={ 
scope: resourceGroup(serviceRG.name)
  name: 'servicesdeployment-${uniqueString(serviceRG.id)}'

}

module proddeploy 'proddeploy.bicep' = {
scope: resourceGroup(productionRG.name)
  name: 'productiondeploymnet-${uniqueString(productionRG.id)}'
  
}


resource existingLocalVirtualNetworkName_peering_to_remote_vnet 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-02-01' = {
  name: '${existingLocalVirtualNetworkName}/peering-to-remote-vnet'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: resourceId(existingRemoteVirtualNetworkResourceGroupName, 'Microsoft.Network/virtualNetworks', existingRemoteVirtualNetworkName)
    }
  }
}
