Write-Host "Environment variables set."



rustc --version

python.exe -m pip install --upgrade pip

$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
  # fallback to python3 if python not found
  $pythonCmd = Get-Command python3 -ErrorAction SilentlyContinue
}
refreshenv
Write-Host 'Creating python virtual environment "scripts/.venv"'
Start-Process -FilePath ($pythonCmd).Source -ArgumentList "-m venv ./scripts/.venv" -Wait -NoNewWindow

$venvPythonPath = "./scripts/.venv/scripts/python.exe"
if (Test-Path -Path "/usr") {
  # fallback to Linux venv path
  $venvPythonPath = "./scripts/.venv/bin/python"
}

$rgname = Read-host "Enter your resource group name where your terraform infra is deployed"
$rgname
$location = Read-Host "Enter your activate genai resource group location"
$subid = Read-Host "Enter your SubID"

cd C:\Users\demouser\activate-genai\scripts
mkdir genai
cd genai



azd init -t https://github.com/Sumit-azure/azure-search-openai-demo -e activate-genai-guan -s $subid -l $location


Write-Host "Navigate to browser to complete the Azure login"
azd auth login

azd up -e activate-genai-guan


