param location string = resourceGroup().location
param env string = 'dev'

module network './modules/networking.bicep' = {
  name: 'vnet-${env}'
  params: {
    location: location
    vnetName: 'vnet-${env}'
  }
}

module kv './modules/keyvault.bicep' = {
  name: 'kv-${env}'
  params: {
    location: location
    kvName: 'kv-${env}'
  }
}

module logs './modules/loganalytics.bicep' = {
  name: 'logs-${env}'
  params: {
    location: location
    workspaceName: 'log-${env}'
  }
}

output vnetId string = network.outputs.vnetId
output kvUri string = kv.outputs.kvUri
output logId string = logs.outputs.workspaceId
