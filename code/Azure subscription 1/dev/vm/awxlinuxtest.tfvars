######Virtual Machine Configuration######
vm_hostname             = "AWXLinuxTest"#<---- The host name of the Virtual machine
resource_group_name     = "RG-INFRA-AWX-TEST"#<---- The resource group where the virtual machi
location                = ""
vm_size                 = "standard_d2s_v3"
identity_type           = "SystemAssigned"
availability_zone       =  []
availability_set_id     = ""
virtual_network_name    = "AZU_APL_VNET01"
subnet_name             = "APL_SN_STG_TESTTIER"
subnet_resource_group_name = "RG-INFRA-NETWORK-01"
#private_ip              = ""
 extra_network_interface = {
   1 = {
     ip = ["10.91.23.149"]
   }
 }
#########################################
#########################################

######Opreating System Configuration#####
#(Reference link)https://docs.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest
vm_os_simple            = "Linux"#<---- The Option to select Windows or Linux Possible values are "WindowsServer" and "Linux"
vm_os_offer           = "0001-com-ubuntu-server-focal"
vm_os_publisher         = "Canonical"
vm_os_sku               = "20_04-lts"
#########################################
#########################################

######Only for Custom Image Reference####
vm_custom_os_id         = ""#<----(Optional) required when the custom OS is used for the deployment.
is_windows_image        = false#<----Required when the custom image is used set to "true" if the custom image is linux
#########################################
#########################################

####Virtual Machine Disk Configuration###
os_disk_type = "Premium_LRS"#<----(Requires) Possible values are "StandardSSD_ZRS", "Premium_LRS", "Premium_ZRS", "StandardSSD_LRS" or "UltraSSD_LRS"
os_disk_size = 127
#Add Extra blocks if additional data disks required.

#########################################
#########################################
#####Boot Diagnostics Configuration#####
boot_diagnostics        = false #<----(required) possible input are "true" or "false"
boot_diagnostics_sa_uri = "" #<----(required when boot diag set it to true) possible input is storage account URI