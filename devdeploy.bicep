@description('VNet name')
param vnetName string = 'vnet_dev_eastus'

@description('Address prefix')
param vnetAddressPrefix string = '10.0.8.0/22'

@description('Name of NSG for Web_dev subnet')
param NSG1 string = 'NSG_Web_dev_eastus'

@description('Subnet 1 Prefix')
param subnet1Prefix string = '10.0.8.0/24'

@description('Subnet 1 Name')
param subnet1Name string = 'Web_dev_eastus'

@description('Name of NSG for App_dev subnet')
param NSG2 string = 'NSG_App_dev_eastus'

@description('Subnet 2 Prefix')
param subnet2Prefix string = '10.0.9.0/24'

@description('Subnet 2 Name')
param subnet2Name string = 'App_dev_eastus'

@description('Name of NSG for DB_dev subnet')
param NSG3 string = 'NSG_DB_dev_eastus'

@description('Subnet 3 Prefix')
param subnet3Prefix string = '10.0.10.0/24'

@description('Subnet 3 Name')
param subnet3Name string = 'DB_dev_eastus'

@description('Subnet 2 Prefix')
param BastionsubnetPrefix string = '10.0.11.0/27'

@description('Bastion Subnet  Name')
param BastionsubnetName string = 'AzureBastionSubnet'

@description('Recovery services vault for dev subscription')
param RecoveryServicesVaultName string = 'RSV-dev-eastus'

@description('Location for all resources.')
param location string = resourceGroup().location
param resourceTags object = {
  Environment: 'Dev'
  Created_By: 'Airnet'
}

resource NSG1_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: NSG1
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource NSG2_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: NSG2
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource NSG3_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: NSG3
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource vnetName_resource 'Microsoft.Network/virtualNetworks@2015-05-01-preview' = {
  name: vnetName
  location: location
  tags: resourceTags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1Prefix
          networkSecurityGroup: {
            id: NSG1_resource.id
          }
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: subnet2Prefix
          networkSecurityGroup: {
            id: NSG2_resource.id
          }
        }
      }
      {
        name: subnet3Name
        properties: {
          addressPrefix: subnet3Prefix
          networkSecurityGroup: {
            id: NSG3_resource.id
          }
        }
      }
      {
        name: BastionsubnetName
        properties: {
          addressPrefix: BastionsubnetPrefix
        }
      }
    ]
  }
}

resource RecoveryServicesVaultName_resource 'Microsoft.RecoveryServices/vaults@2018-01-10' = {
  name: RecoveryServicesVaultName
  location: resourceGroup().location
  tags: resourceTags
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}
