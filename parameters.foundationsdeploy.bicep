@description('services resource group name - foundationsdeploy')
param servicesGroupName string = 'rg_services_deployment'

@description('production resource group name - foundationsdeploy')
param productionGroupName string = 'rg_production_deployment'

@description('Resource group location - foundationsdeploy')
param location string = 'East US'

@description('resource tags for deployed resources - foundationsdeploy')
param resourceTags object = {
  Environment: 'Services'
  Created_By: 'Airnet'
}

@description('VNet name - servicesdeploy')
param vnetName string = 'vnet_services_eastus'

@description('Address prefix - servicesdeploy')
param vnetAddressPrefix string = '10.0.0.0/24'

@description('Name of NSG for Web_Users subnet - servicesdeploy')
param NSG1 string = 'NSG_services_eastus'

@description('Subnet 1 Prefix - servicesdeploy')
param subnet1Prefix string = '10.0.0.0/25'

@description('Subnet 1 Name - servicesdeploy')
param subnet1Name string = 'services_eastus'

@description('Gateway Subnet Prefix - servicesdeploy')
param GatewaysubnetPrefix string = '10.0.0.128/27'

@description('Gateway Subnet Name - servicesdeploy')
param GatewaysubnetName string = 'GatewaySubnet'

@description('Bastion Subnet Prefix - servicesdeploy')
param BastionsubnetPrefix string = '10.0.0.160/27'

@description('Bastion Subnet  Name - servicesdeploy')
param BastionsubnetName string = 'AzureBastionSubnet'

@description('log analytics name and sku - servicesdeploy')
param loganalyticsname string = 'la-Services-Eastus'
param loganalyticssku string = 'pergb2018'

@description('Recovery services vault for services subscription')
param RecoveryServicesVaultName string = 'rsv-services-eastus'

