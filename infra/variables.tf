# suffix 后缀
variable "suffix" {
  default = "yourname"
}

# 资源组
variable "resource_group_name" {
  default = "ODL-GenAI-CL-1332115-01"
}

# 位置
variable "location" {
  default = "east us"
}

# 第二区域
variable "secondary_location" {
  default = "Southeast Asia"
}

# 日志名称
variable "log_name" {
  default = "log-activate-genai"
}

# Azure OpenAI 服务名称
variable "azopenai_name" {
  default = "cog-openai-activate-genai"
}

# 搜索服务名称
variable "search_name" {
  default = "search-activate-genai"
}

# 表单识别器名称
variable "form_recognizer_name" {
  default = "cog-forms-activate-genai"
}

# 存储容器名称
variable "storage_account_name" {
  default = "stgenai"
}

# 事件中心名称
variable "eventhub_name" {
  default = "evh-activate-genai"
}

# api管理器名称
variable "apim_name" {
  default = "apim-activate-genai"
}

# 应用洞察名称
variable "appi_name" {
  default = "appi-activate-genai"
}

# 发布者名称
variable "publisher_name" {
  default = "contoso"
}

# 发布者电子邮件
variable "publisher_email" {
  default = "admin@contoso.com"
}

# 虚拟网络名称
variable "virtual_network_name" {
  default = "vnet-activate-genai"
}

# 子网名称
variable "managed_identity_name" {
  default = "id-activate-genai"
}

# cae名称
variable "cae_name" {
  default = "cae-activate-genai"
}

# 后台名称
variable "ca_back_name" {
  default = "ca-back-activate-genai"
}

# webapi名称
variable "ca_webapi_name" {
  default = "ca-webapi-activate-genai"
}

# webapp名称
variable "ca_webapp_name" {
  default = "ca-webapp-activate-genai"
}

# 是否启用 Entra ID 认证
variable "enable_entra_id_authentication" {
  default = false
}

# 是否启用 APIM
variable "enable_apim" {
  default = false
}
