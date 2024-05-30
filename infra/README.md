# 部署说明
 

1. 登录 Azure 

执行以下命令 
```
az login --use-device-code 
```



```
cd infra
terraform init
terraform apply


```



```
export AZURE_PRINCIPAL_ID="<principal id>"
export AZURE_RESOURCE_GROUP="<resource group>" 
export AZURE_SUBSCRIPTION_ID="<subscription id>"
export AZURE_TENANT_ID="<azure tenant id>"
export AZURE_STORAGE_ACCOUNT="<storage account name>"
export AZURE_STORAGE_CONTAINER="content"
export AZURE_SEARCH_SERVICE="<search service name>"
export OPENAI_HOST="azure"
export AZURE_OPENAI_SERVICE="<openai service name>"
export OPENAI_API_KEY=""
export OPENAI_ORGANIZATION=""
export AZURE_OPENAI_EMB_DEPLOYMENT="text-embedding-ada-002"
export AZURE_OPENAI_EMB_MODEL_NAME="text-embedding-ada-002"
export AZURE_SEARCH_INDEX="gptkbindex"
```


Login to Azure:

```
azd auth login --client-id <client-id> --client-secret <client-password> --tenant-id <tenant-id>
```


Deploy the Azure Search Index and upload the sample documents:

```
./scripts/prepdocs.sh
```


terraform apply  -var 'suffix=guan' -var 'resource_group_name=ODL-GenAI-CL-1332115-01-guan' -no-color 

