@description('Address prefix')
param vnetIPspace string = '10.0.0.0/24'

@description('Subnet 1 Prefix')
param servicessubnetIP string = '10.0.0.0/25'

@description('Bastion Subnet Prefix')
param BastionsubnetIP string = '10.0.0.128/26'

@description('Gateway Subnet Prefix')
param GatewaysubnetIP string = '10.0.0.192/27'

param resourceTags object = {
  Environment: 'Services'
  Created_By: 'Dataprise'
}

var location = resourceGroup().location
var servicesVnet = 'vnet_services_${location}'
var servicesNSG = 'NSG_services_${location}'
var servicesSubnet = 'services_${location}'
var servicesla = 'la-services-${location}'
var servicesrsv = 'rsv-services-${location}'

resource NSG1_resource 'Microsoft.Network/networkSecurityGroups@2018-10-01' = {
  name: servicesNSG
  location: location
  tags: resourceTags
  properties: {
    securityRules: []
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2015-05-01-preview' = {
  name: servicesVnet
  location: location
  tags: resourceTags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetIPspace
      ]
    }
    subnets: [
      {
        name: servicesSubnet
        properties: {
          addressPrefix: servicessubnetIP
          networkSecurityGroup: {
            id: NSG1_resource.id
          }
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: GatewaysubnetIP
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
  name: servicesla
  location: location
  tags: resourceTags
  properties: {
    sku: {
      name: 'pergb2018'
    }
  }
}

resource RecoveryServicesVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: servicesrsv
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

resource GatewayPublicIP_resource 'Microsoft.Network/publicIPAddresses@2018-10-01' = {
  location: location
  tags: resourceTags
  name: 'GWpubIP'
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource Gateway 'Microsoft.Network/virtualNetworkGateways@2018-10-01' = {
  location: location
  tags: resourceTags
  name: 'Services-East-GW'
  properties: {
    ipConfigurations: [
      {
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', servicesVnet, 'GatewaySubnet')
          }
          publicIPAddress: {
            id: GatewayPublicIP_resource.id
          }
        }
        name: 'GWipConfig1'
      }
    ]
    gatewayType: 'VPN'
    vpnType: 'RouteBased'
    enableBgp: false
    sku: {
      name: 'Basic'
      tier: 'Basic'
    }
  }
  dependsOn: [
    vnet

  ]
}
