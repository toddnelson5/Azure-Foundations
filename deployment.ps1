az login

az deployment sub create --location "East US" --template-file ./foundationsdeploy.bicep 

az deployment sub create --location "East US" --template-file ./main.bicep --parameters ./main.parameters.json
