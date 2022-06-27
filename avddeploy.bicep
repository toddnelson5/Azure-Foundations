@description('VNet name')
param vnetName string = 'vnet_avd_eastus'

@description('Address prefix')
param vnetAddressPrefix string = '10.0.12.0/22'

@description('Name of NSG for Web_Prod subnet')
param NSG1 string = 'NSG_AVD_Users_eastus'

@description('Subnet 1 Prefix')
param subnet1Prefix string = '10.0.12.0/24'

@description('Subnet 1 Name')
param subnet1Name string = 'AVD_Users_eastus'

@description('Name of NSG for App_Prod subnet')
param NSG2 string = 'NSG_AVD_Admins_eastus'

@description('Subnet 2 Prefix')
param subnet2Prefix string = '10.0.13.0/24'

@description('Subnet 2 Name')
param subnet2Name string = 'AVD_Admins_eastus'

@description('Subnet 2 Prefix')
param BastionsubnetPrefix string = '10.0.14.0/27'

@description('Bastion Subnet  Name')
param BastionsubnetName string = 'AzureBastionSubnet'

@description('Recovery services vault for users subscription')
param RecoveryServicesVaultName string = 'RSV-avd-eastus'

@description('Location for all resources.')
param location string = resourceGroup().location
param resourceTags object = {
  Environment: 'AVD'
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
