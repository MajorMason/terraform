#For secrets
Set-Location $GitBasePath\SecretOnly

#Set variable to avoid having secret in my source files.
#The "TF_VAR" tells POSH what to look for along with the "KV" being the variable name.
$env:TF_VAR_KV="/subscriptions/$SubID/resourceGroups/dev-rg/providers/Microsoft.KeyVault/vaults/devvault"

#NOTE: Calling ARM templates in Terraform is not recommended because the created resources
#from said ARM template will not be managed by Terraform and cause state drift.
