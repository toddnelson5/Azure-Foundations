param vnetIPSpace string = '10.0.4.0/22'

param appSubnetIP string = '10.0.4.0/24'
param dbSubnetIP string = '10.0.5.0/24'
param webSubnetIP string = '10.0.6.0/24'
param BastionsubnetIP string = '10.0.7.0/26'

param resourceTags object = {
  Environment: 'Production'
  Created_By: 'Dataprise'
}

var location = resourceGroup().location
var prodVnet = 'vnet_prod_${location}'
var appNSG = 'NSG_app_prod_${location}'
var dbNSG = 'NSG_db_prod_${location}'
var webNSG = 'NSG_web_prod_${location}'
var appSubnet = 'app_prod_${location}'
var dbSubnet = 'db_prod_${location}'
var webSubnet = 'web_prod_${location}'
var prodla = 'la-prod-${location}'
var prodrsv = 'rsv-prod-${location}'

resource NSG1_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: appNSG
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource NSG2_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: dbNSG
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource NSG3_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: webNSG
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}


resource vnet 'Microsoft.Network/virtualNetworks@2015-05-01-preview' = {
  name: prodVnet
  location: location
  tags: resourceTags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetIPSpace
      ]
    }
    subnets: [
      {
        name: appSubnet
        properties: {
          addressPrefix: appSubnetIP
          networkSecurityGroup: {
            id: NSG1_resource.id
          }
        }
      }
      {
        name: dbSubnet
        properties: {
          addressPrefix: dbSubnetIP
          networkSecurityGroup: {
            id: NSG2_resource.id
          }
        }
      }
      {
        name: webSubnet
        properties: {
          addressPrefix: webSubnetIP
          networkSecurityGroup: {
            id: NSG3_resource.id
          }
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: BastionsubnetIP
        }
      }
    ]
  }
}

resource loganalyticsname_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: prodla
  location: location
  tags: resourceTags
  properties: {
    sku: {
      name: 'pergb2018'
    }
  }
}

resource RecoveryServicesVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: prodrsv
  location: location
  tags: resourceTags
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

