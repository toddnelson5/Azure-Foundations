param vnetIPSpace string = '10.0.12.0/22'

param avdUsersSubnetIP string = '10.0.12.0/24'
param avdAdminsSubnetIP string = '10.0.13.0/24'
param BastionsubnetIP string = '10.0.14.0/26'

param resourceTags object = {
  Environment: 'AVD'
  Created_By: 'Dataprise'
}

var location = resourceGroup().location
var avdVnet = 'vnet_avd_${location}'
var usersNSG = 'NSG_avd_users_${location}'
var adminNSG = 'NSG_avd_admins_${location}'
var avdUsersSubnet = 'app_avd_${location}'
var avdAdminsSubnet = 'db_avd_${location}'
var avdla = 'la-avd-${location}'
var avdrsv = 'rsv-avd-${location}'

resource NSG1_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: usersNSG
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource NSG2_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: adminNSG
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2015-05-01-preview' = {
  name: avdVnet
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
        name: avdUsersSubnet
        properties: {
          addressPrefix: avdUsersSubnetIP
          networkSecurityGroup: {
            id: NSG1_resource.id
          }
        }
      }
      {
        name: avdAdminsSubnet
        properties: {
          addressPrefix: avdAdminsSubnetIP
          networkSecurityGroup: {
            id: NSG2_resource.id
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

resource RecoveryServicesVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: avdrsv
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

resource loganalyticsname_resource 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: avdla
  location: location
  tags: resourceTags
  properties: {
    sku: {
      name: 'pergb2018'
    }
  }
}
