@description('VNet name')
param vnetName string = 'vnet_services_eastus'

@description('Address prefix')
param vnetAddressPrefix string = '10.0.0.0/24'

@description('Name of NSG for Web_Users subnet')
param NSG1 string = 'NSG_services_eastus'

@description('Subnet 1 Prefix')
param subnet1Prefix string = '10.0.0.0/25'

@description('Subnet 1 Name')
param subnet1Name string = 'services_eastus'

@description('Bastion Subnet Prefix')
param BastionsubnetPrefix string = '10.0.0.128/26'

@description('Bastion Subnet  Name')
param BastionsubnetName string = 'AzureBastionSubnet'

@description('Gateway Subnet Prefix')
param GatewaysubnetPrefix string = '10.0.0.192/27'

@description('Gateway Subnet Name')
param GatewaysubnetName string = 'GatewaySubnet'
param loganalyticsname string = 'la-Services-Eastus'
param loganalyticssku string = 'pergb2018'

@description('Recovery services vault for services subscription')
param RecoveryServicesVaultName string = 'RSV-services-eastus'

@description('Location for all resources.')
param location string = resourceGroup().location
param resourceTags object = {
  Environment: 'Services'
  Created_By: 'Dataprise'
}

resource NSG1_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: NSG1
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2015-05-01-preview' = {
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
        name: GatewaysubnetName
        properties: {
          addressPrefix: GatewaysubnetPrefix
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

resource loganalyticsname_resource 'Microsoft.OperationalInsights/workspaces@2017-03-15-preview' = {
  name: loganalyticsname
  location: location
  tags: resourceTags
  properties: {
    sku: {
      name: loganalyticssku
    }
  }
}

resource RecoveryServicesVault 'Microsoft.RecoveryServices/vaults@2018-01-10' = {
  name: RecoveryServicesVaultName
  location: resourceGroup().location
  tags: resourceTags
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
  }
}