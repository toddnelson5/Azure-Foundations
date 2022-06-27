targetScope = 'subscription'

@description('Specify a unique name for your offer')
param mspOfferName string = ' InvictaMSPAzureManagedServices'

@description('Name of the Managed Service Provider offering')
param mspOfferDescription string = 'Invicta MSP Azure Managed Services Offer'

@description('Specify the tenant id of the Managed Service Provider')
param managedByTenantId string = 'e6a395b6-5b72-42ce-b67c-ee0b0225a4dc'

@description('Specify an array of objects, containing tuples of Azure Active Directory principalId, a Azure roleDefinitionId, and an optional principalIdDisplayName. The roleDefinition specified is granted to the principalId in the provider\'s Active Directory and the principalIdDisplayName is visible to customers.')
param authorizations array = [
  {
    principalId: '572cc9fe-e7a6-4ac2-bf4d-cd44c88d5889'
    roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
    principalIdDisplayName: 'AzureMSPTechs'
  }
  {
    principalId: '572cc9fe-e7a6-4ac2-bf4d-cd44c88d5889'
    roleDefinitionId: '91c1777a-f3dc-4fae-b103-61d183457e46'
    principalIdDisplayName: 'AzureMSPTechs'
  }
]

var mspRegistrationName_var = guid(mspOfferName)
var mspAssignmentName_var = guid(mspOfferName)

resource mspRegistrationName 'Microsoft.ManagedServices/registrationDefinitions@2019-09-01' = {
  name: mspRegistrationName_var
  properties: {
    registrationDefinitionName: mspOfferName
    description: mspOfferDescription
    managedByTenantId: managedByTenantId
    authorizations: authorizations
  }
}

resource mspAssignmentName 'Microsoft.ManagedServices/registrationAssignments@2019-09-01' = {
  name: mspAssignmentName_var
  properties: {
    registrationDefinitionId: mspRegistrationName.id
  }
}

output mspOfferName string = 'Managed by ${mspOfferName}'
output authorizations array = authorizations
