@description('VNet name')
param vnetName string = 'vnet_prod_eastus'

@description('Address prefix')
param vnetAddressPrefix string = '10.0.4.0/22'

@description('Name of NSG for Web_Prod subnet')
param NSG1 string = 'NSG_Web_Prod_eastus'

@description('Subnet 1 Prefix')
param subnet1Prefix string = '10.0.4.0/24'

@description('Subnet 1 Name')
param subnet1Name string = 'Web_Prod_eastus'

@description('Name of NSG for App_Prod subnet')
param NSG2 string = 'NSG_App_Prod_eastus'

@description('Subnet 2 Prefix')
param subnet2Prefix string = '10.0.5.0/24'

@description('Subnet 2 Name')
param subnet2Name string = 'App_Prod_eastus'

@description('Name of NSG for DB_Prod subnet')
param NSG3 string = 'NSG_DB_Prod_eastus'

@description('Subnet 3 Prefix')
param subnet3Prefix string = '10.0.6.0/24'

@description('Subnet 3 Name')
param subnet3Name string = 'DB_Prod_eastus'

@description('Subnet 2 Prefix')
param BastionsubnetPrefix string = '10.0.7.0/27'

@description('Bastion Subnet  Name')
param BastionsubnetName string = 'AzureBastionSubnet'

@description('Recovery Services Vault for Subscription')
param RecoverserviceVaultName string = 'RSV-prod-eastus'

@description('Location for all resources.')
param location string = resourceGroup().location
param resourceTags object = {
  Environment: 'Production'
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

resource vnetName_resource 'Microsoft.Network/virtualNetworks@2018-10-01' = {
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

resource RecoverserviceVaultName_resource 'Microsoft.RecoveryServices/vaults@2018-01-10' = {
  name: RecoverserviceVaultName
  location: resourceGroup().location
  tags: resourceTags
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {}
}
