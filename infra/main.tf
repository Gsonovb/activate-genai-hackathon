// 获取当前的 Azure 订阅信息
data "azurerm_subscription" "current" {}

// 生成一个随机 ID
resource "random_id" "random" {
  byte_length = 8
}

// 创建一个 Azure 资源组
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name  // 资源组的名称
  location = var.location  // 资源组的位置
}

// 定义一些本地变量
locals {
  name_sufix           = "${substr(lower(random_id.random.hex), 1, 4)}-${var.suffix}"  // 随机 ID 的后缀
  storage_account_name = "${var.storage_account_name}${local.name_sufix}"  // 存储账户的名称
  search_name = "${var.search_name}${local.name_sufix}"  // 搜索服务的名称
  form_recognizer_name = "${var.form_recognizer_name}${local.name_sufix}"  // 表单识别器的名称
  azopenai_name = "${var.azopenai_name}${local.name_sufix}"  // Azure OpenAI 的名称
  
  //-------------------以下是新增的变量-------------------
  log_name = "${var.log_name}${local.name_sufix}"  // 日志的名称
  eventhub_name = "${var.eventhub_name}${local.name_sufix}"  // 事件中心的名称
  apim_name = "${var.apim_name}${local.name_sufix}"  // API 管理的名称
  appi_name = "${var.appi_name}${local.name_sufix}"  // 应用洞察的名称
  virtual_network_name = "${var.virtual_network_name}${local.name_sufix}"  // 虚拟网络的名称
  managed_identity_name = "${var.managed_identity_name}${local.name_sufix}"  // 托管身份的名称  
  cae_name = "${var.cae_name}${local.name_sufix}"  // CAE 的名称
  ca_back_name = "${var.ca_back_name}${local.name_sufix}"  // CA 后端的名称
  ca_webapi_name = "${var.ca_webapi_name}${local.name_sufix}"  // CA Web API 的名称
  ca_webapp_name = "${var.ca_webapp_name}${local.name_sufix}"  // CA Web 应用的名称


}


// 创建一个虚拟网络模块
module "vnet" {
  source               = "./modules/vnet"  // 模块的源代码路径
  location             = azurerm_resource_group.rg.location  // 资源组的位置
  resource_group_name  = azurerm_resource_group.rg.name  // 资源组的名称
  virtual_network_name = local.virtual_network_name  // 虚拟网络的名称
}

// 创建一个网络安全组模块
module "nsg" {
  source              = "./modules/nsg"  // 模块的源代码路径
  location            = azurerm_resource_group.rg.location  // 资源组的位置
  resource_group_name = azurerm_resource_group.rg.name  // 资源组的名称
  nsg_apim_name       = "nsg-apim"  // API 管理的网络安全组名称
  apim_subnet_id      = module.vnet.apim_subnet_id  // API 管理的子网 ID
  nsg_cae_name        = "nsg-cae"  // CAE 的网络安全组名称
  cae_subnet_id       = module.vnet.cae_subnet_id  // CAE 的子网 ID
  nsg_pe_name         = "nsg-pe"  // PE 的网络安全组名称
  pe_subnet_id        = module.vnet.pe_subnet_id  // PE 的子网 ID
}

// 创建一个 API 管理模块
module "apim" {
  source                   = "./modules/apim"  // 模块的源代码路径
  location                 = azurerm_resource_group.rg.location  // 资源组的位置
  resource_group_name      = azurerm_resource_group.rg.name  // 资源组的名称
  apim_name                = local.apim_name // API 管理的名称
  apim_subnet_id           = module.vnet.apim_subnet_id  // API 管理的子网 ID
  publisher_name           = var.publisher_name  // 发布者的名称
  publisher_email          = var.publisher_email  // 发布者的电子邮件
  enable_apim              = var.enable_apim  // 是否启用 API 管理
  appi_resource_id         = module.appi.appi_id  // 应用洞察的资源 ID
  appi_instrumentation_key = module.appi.appi_key  // 应用洞察的仪器密钥
  openai_service_name      = "test"  // OpenAI 服务的名称
  openai_service_endpoint  = "test"  // OpenAI 服务的端点
  tenant_id                = data.azurerm_subscription.current.tenant_id  // 租户 ID

  depends_on = [module.nsg]  // 依赖于网络安全组模块
}

// 创建一个托管身份模块
module "mi" {
  source                = "./modules/mi"  // 模块的源代码路径
  location              = azurerm_resource_group.rg.location  // 资源组的位置
  resource_group_name   = azurerm_resource_group.rg.name  // 资源组的名称
  managed_identity_name = local.managed_identity_name // 托管身份的名称
}

// 创建一个角色分配资源
resource "azurerm_role_assignment" "id_reader" {
  scope                = azurerm_resource_group.rg.id  // 资源组的 ID
  role_definition_name = "Reader"  // 角色的名称
  principal_id         = module.mi.principal_id  // 主体 ID
}

// 创建一个日志模块
module "log" {
  source              = "./modules/log"  // 模块的源代码路径
  location            = azurerm_resource_group.rg.location  // 资源组的位置
  resource_group_name = azurerm_resource_group.rg.name  // 资源组的名称
  log_name            = local.log_name // 日志的名称
}

// 创建一个应用洞察模块
module "appi" {
  source              = "./modules/appi"  // 模块的源代码路径
  location            = azurerm_resource_group.rg.location  // 资源组的位置
  resource_group_name = azurerm_resource_group.rg.name  // 资源组的名称
  appi_name           = local.appi_name  // 应用洞察的名称
  log_id              = module.log.log_id  // 日志的 ID
}


// 创建一个 CAE 模块
module "cae" {
  source            = "./modules/cae"  // 模块的源代码路径
  location          = azurerm_resource_group.rg.location  // 资源组的位置
  resource_group_id = azurerm_resource_group.rg.id  // 资源组的 ID
  cae_name          = local.cae_name  // CAE 的名称
  cae_subnet_id     = module.vnet.cae_subnet_id  // CAE 的子网 ID
  log_workspace_id  = module.log.log_workspace_id  // 日志工作区的 ID
  log_key           = module.log.log_key  // 日志的密钥
  appi_key          = module.appi.appi_key  // 应用洞察的密钥
}

// 创建一个 CA 后端模块
module "ca_back" {
  source                         = "./modules/ca-back"  // 模块的源代码路径
  location                       = azurerm_resource_group.rg.location  // 资源组的位置
  resource_group_id              = azurerm_resource_group.rg.id  // 资源组的 ID
  ca_name                        = local.ca_back_name  // CA 的名称
  cae_id                         = module.cae.cae_id  // CAE 的 ID
  managed_identity_id            = module.mi.mi_id  // 托管身份的 ID
  chat_gpt_deployment            = "gpt-35-turbo"  // 聊天 GPT 的部署
  chat_gpt_model                 = "gpt-35-turbo"  // 聊天 GPT 的模型
  embeddings_deployment          = "text-embedding-ada-002"  // 嵌入部署
  embeddings_model               = "text-embedding-ada-002"  // 嵌入模型
  storage_account_name           = "${local.storage_account_name}"  // 存储账户的名称
  storage_container_name         = "ca_back"  // 存储容器的名称
  search_service_name            = "${local.search_name}"  // 搜索服务的名称
  search_index_name              = "azureindex"  // 搜索索引的名称
  openai_service_name            = "${local.azopenai_name}"  // OpenAI 服务的名称
  tenant_id                      = data.azurerm_subscription.current.tenant_id  // 租户 ID
  managed_identity_client_id     = module.mi.client_id  // 托管身份的客户端 ID
  enable_entra_id_authentication = var.enable_entra_id_authentication  // 是否启用 Entra ID 认证
}

# 创建一个 CA Web API 模块
# module "ca_webapi" {
#   source                     = "./modules/ca-webapi"  // 模块的源代码路径
#   location                   = azurerm_resource_group.rg.location  // 资源组的位置
#   resource_group_id          = azurerm_resource_group.rg.id  // 资源组的 ID
#   ca_name                    = local.ca_webapi_name  // CA 的名称
#   cae_id                     = module.cae.cae_id  // CAE 的 ID
#   cae_default_domain         = module.cae.defaultDomain  // CAE 的默认域
#   ca_webapp_name             = local.ca_webapp_name  // CA Web 应用的名称
#   managed_identity_id        = module.mi.mi_id  // 托管身份的 ID
#   chat_gpt_deployment        = "test"  // 聊天 GPT 的部署
#   chat_gpt_model             = "test"  // 聊天 GPT 的模型
#   embeddings_deployment      = "test"  // 嵌入部署
#   embeddings_model           = "test"  // 嵌入模型
#   storage_account_name       = "${local.storage_account_name}"·  // 存储账户的名称
#   storage_container_name     = module.st.storage_container_name  // 存储容器的名称
#   search_service_name        = module.search.search_service_name  // 搜索服务的名称
#   search_index_name          = module.search.search_index_name  // 搜索索引的名称
#   openai_service_name        = module.openai.openai_service_name  // OpenAI 服务的名称
#   tenant_id                  = data.azurerm_subscription.current.tenant_id  // 租户 ID
#   managed_identity_client_id = module.mi.client_id  // 托管身份的客户端 ID
# }

# 创建一个 CA Web 应用模块
# module "ca_webapp" {
#   source                     = "./modules/ca-webapp"  // 模块的源代码路径
#   location                   = azurerm_resource_group.rg.location  // 资源组的位置
#   resource_group_id          = azurerm_resource_group.rg.id  // 资源组的 ID
#   ca_name                    = local.ca_webapp_name  // CA 的名称
#   cae_id                     = module.cae.cae_id  // CAE 的 ID
#   managed_identity_id        = module.mi.mi_id  // 托管身份的 ID
#   tenant_id                  = data.azurerm_subscription.current.tenant_id  // 租户 ID
#   managed_identity_client_id = module.mi.client_id  // 托管身份的客户端 ID
#   backend_url                = module.ca_webapi.fqdn  // 后端 URL
# }
