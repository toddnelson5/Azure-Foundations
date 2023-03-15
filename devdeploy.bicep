param vnetIPSpace string = '10.0.8.0/22'

param appSubnetIP string = '10.0.8.0/24'
param dbSubnetIP string = '10.0.9.0/24'
param webSubnetIP string = '10.0.10.0/24'
param BastionsubnetIP string = '10.0.11.0/26'

param resourceTags object = {
  Environment: 'Dev/Test'
  Created_By: 'Dataprise'
}

var location = resourceGroup().location
var devVnet = 'vnet_dev_${location}'
var appNSG = 'NSG_app_dev_${location}'
var dbNSG = 'NSG_db_dev_${location}'
var webNSG = 'NSG_web_dev_${location}'
var appSubnet = 'app_dev_${location}'
var dbSubnet = 'db_dev_${location}'
var webSubnet = 'web_dev_${location}'
var devla = 'la-dev-${location}'
var devrsv = 'rsv-dev-${location}'

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
  name: devVnet
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
  name: devla
  location: location
  tags: resourceTags
  properties: {
    sku: {
      name: 'pergb2018'
    }
  }
}

resource RecoveryServicesVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: devrsv
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

