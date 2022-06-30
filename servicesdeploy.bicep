resource teststor 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'teststorage06282022'
  location: 'eastus'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
