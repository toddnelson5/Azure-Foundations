# Foundations-3

These are JSON templates for a new azure foundations deployment.  The deployments include the basic infrastructure for each subscription.  They include objects like VNETs, NSGs, Virtual Network Gateways, Recovey Services Vaults, and a single Log Analytics account.

If the following templates are deployed as is they will deploy a /20 for all subscriptions and deployments.  You can change the IP ranges for any or all deployments.  The table below shows the current breakdown for each deployment. 

| IP Range |	/20 for all deployments |	NSGs |	10.0.0.0-10.0.15.255 |
| -------- | ------------------------ | ---- | --------------------- |
|  Vnet_Services |	/24 | |	10.0.0.0/24 |
| /25 |	ServicesSubnet | NSG_Services |	10.0.0.0/25 |
| /26 |	BastionSubnet |	None |	10.0.0.128/26 |
| /27 |	GatewaySubnet |	None |	10.0.0.192/27 |
| Vnet_Prod |	/22 | |		10.0.4.0/22 |
| /24 |	AppSubnet |	NSG_App |	10.0.4.0/24 |
| /24 |	WebSubnet |	NSG_Web |	10.0.5.0/24 |
| /24 |	DBSubnet |	NSG_DB |	10.0.6.0/24 |
| /26 |	BastionSubnet |	None |	10.0.7.0/26 |
| Vnet_Dev |	/22 | |		10.0.8.0/22 |
| /24 |	AppDevSubnet |	NSG_App |	10.0.8.0/24 |
| /24 |	WebDevSubnet |	NSG_Web |	10.0.9.0/24 |
| /24 |	DBDevSubnet |	NSG_DB |	10.0.10.0/24 |
| /26 |	BastionSubnet |	None |	10.0.11.0/26 |
| Vnet_Storage | | |			0.0.0.0 |
|	 | No Networking |	No NSG	|
| Vnet Users |	/22 |		10.0.12.0/22 |
| /24 |	WVD_UsersSubnet |	NSG_Users |	10.0.12.0/24 |
| /24 |	WVD_AdminsSubnet |	NSG_Admins |	10.0.13.0/24 |
| /26 |	BastionSubnet |	None |	10.0.14.0/26 |

# Services Deployment with Gateway

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Fservicesdeploy.json)
[![Deploy To Azure Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Fservicesdeploy.json)

# Services Deployment with Basic Gateway

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2FservicesbasicGWdeploy.json)
[![Deploy To Azure Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2FservicesbasicGWdeploy.json)


# Services Deployment with no Gateway

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2FservicesnoGWdeploy.json)
[![Deploy To Azure Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2FservicesnoGWdeploy.json)


# Production Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Fproddeploy.json)
[![Deploy To Azure Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Fproddeploy.json)


# Production without Bastion Subnet

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Fprodnobastiondeploy.json)
[![Deploy To Azure Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Fprodnobastiondeploy.json)


# Development Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Fdevdeploy.json)
[![Deploy To Azure Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Fdevdeploy.json)


# AVD Deployment

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Favddeploy.json)
[![Deploy To Azure Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftoddnelson5%2FFoundations-3%2Fmain%2Favddeploy.json)










