# 部署说明
 

1. 登录 Azure 

执行以下命令 
```
az login --use-device-code 
```


2. 打开文件'./scripts/prepdocs.ps1'

    修改 ‘activate-genai’ 环境名称为自己名称（有两处

2. 打开文件夹

```pwsh
cd scripts
```



3. 设置环境变量

```


$env:AZURE_RESOURCE_GROUP="ODL-GenAI-CL-1332115-01"
$env:AZURE_SUBSCRIPTION_ID="76c8b388-e77c-40aa-a861-72d37f0184fd"
$env:AZURE_TENANT_ID="704dc9af-1950-40f9-80df-7d85b43741b4"

$env:OPENAI_HOST="azure"

$env:AZURE_OPENAI_EMB_DEPLOYMENT="text-embedding-ada-002"
$env:AZURE_OPENAI_EMB_MODEL_NAME="text-embedding-ada-002"

```


```
./prepdocs.ps1
```