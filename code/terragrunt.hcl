locals {
  # Automatically load region-level variables

  subscription_vars  = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  subscription_id       = local.subscription_vars.locals.subscription_id
 
}  

# Inject the remote backend configuration in all the modules that includes the root file without having to define them in the underlying modules 
remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  # Store the terraform state files in a blob container located on an azure storage account
  config = {
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    resource_group_name  = get_env("REMOTE_STATE_RESOURCE_GROUP", "Jenkins_group")
    storage_account_name = get_env("REMOTE_STATE_STORAGE_ACCOUNT", "tfbackendfile1")
    container_name       = get_env("REMOTE_STATE_STORAGE_CONTAINER", "tfstate")
    use_msi              = true
    subscription_id      = "18421bbf-674e-4b2a-b431-da66ee84f1f9"
    tenant_id            = "66bbf87c-6b39-43d5-ba5b-ff09d1665e6e"
  }
}
generate "locals" {
  path      = "locals.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
locals {
  
  subscription_id       = "${local.subscription_id}"
 
}
EOF
}

# Inject this provider configuration in all the modules that includes the root file without having to define them in the underlying modules
# This instructs Terragrunt to create the file provider.tf in the working directory (where Terragrunt calls terraform) before it calls any 
# of the Terraform commands (e.g plan, apply, validate, etc)
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
  use_msi = true
  skip_provider_registration = true
  subscription_id =  "${local.subscription_id}"
}
EOF
}