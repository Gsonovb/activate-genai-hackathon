
// 资源组名称
output "resource_group_name" {
    value = "${azurerm_resource_group.rg.name}"
    description = "The name of the resource group"
}

// 订阅ID
output "subscription_id" {
    value = "${data.azurerm_subscription.current.subscription_id}"
    description = "The subscription ID used"
}

// 租户ID
output "tenant_id" {
    value = "${data.azurerm_subscription.current.tenant_id}"
    description = "The tenant ID used"
}


// 存储帐户名称
output "storage_account_name" {
    value = "${local.storage_account_name}"
    description = "The name of the storage account"
}

# // 事件中心名称
output "eventhub_name" {
    value = "${local.eventhub_name}"
    description = "The name of the event hub"
}


// 搜索服务名称
output "search_name" {
  value = local.search_name
  description = "The name of the search service"
}

// 表单识别服务名称
output "form_recognizer_name" {
  value = local.form_recognizer_name
  description = "The name of the form recognizer service"
}

output "azopenai_name" {
    value = local.azopenai_name
    description = "The name of the Azure OpenAI service"
}


output "log_name" {
    value = local.log_name
    description = "The name of the log"
}


output "apim_name" {
  value = local.apim_name
    description = "The name of the API management"
}

output "appi_name" {
  value = local.appi_name
    description = "The name of the application insight"
}

output "virtual_network_name" {
  value = local.virtual_network_name
    description = "The name of the virtual network"
}

output "managed_identity_name" {
  value = local.managed_identity_name
    description = "The name of the managed identity"
}

output "cae_name" {
  value = local.cae_name
    description = "The name of the CAE"
}

output "ca_back_name" {
  value = local.ca_back_name
    description = "The name of the CA backend"
}

output "ca_webapi_name" {
  value = local.ca_webapi_name
    description = "The name of the CA web API"
}

output "ca_webapp_name" {
  value = local.ca_webapp_name
    description = "The name of the CA web app"
}



# export AZURE_PRINCIPAL_ID="<principal id>"
# export AZURE_RESOURCE_GROUP="<resource group>" 
# export AZURE_SUBSCRIPTION_ID="<subscription id>"
# export AZURE_TENANT_ID="<azure tenant id>"
# export AZURE_STORAGE_ACCOUNT="<storage account name>"
# export AZURE_STORAGE_CONTAINER="content"
# export AZURE_SEARCH_SERVICE="<search service name>"
# export OPENAI_HOST="azure"
# export AZURE_OPENAI_SERVICE="<openai service name>"
# export OPENAI_API_KEY=""
# export OPENAI_ORGANIZATION=""
# export AZURE_OPENAI_EMB_DEPLOYMENT="text-embedding-ada-002"
# export AZURE_OPENAI_EMB_MODEL_NAME="text-embedding-ada-002"
# export AZURE_SEARCH_INDEX="gptkbindex"