targetScope = 'subscription'

resource serviceRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: servicesGroupName
  location: location
  tags: resourceTags
  properties:{
    
  }
}

module servicesdeploy 'servicesnoGWdeploy.bicep' ={ 
  scope: resourceGroup(serviceRG.name)
    name: 'servicesdeployment-${uniqueString(serviceRG.id)}'
  
}

