######Virtual Machine Configuration######
vm_hostname             = "AWXLinuxTest"#<---- The host name of the Virtual machine
resource_group_name     = "Jenkins_group"#<---- The resource group where the virtual machi
location                = ""
vm_size                 = "standard_d2s_v3"
identity_type           = "SystemAssigned"
availability_zone       =  []
availability_set_id     = ""
virtual_network_name    = "Jenkins_group-vnet"
subnet_name             = "default"
subnet_resource_group_name = "Jenkins_group"
#private_ip              = ""
 extra_network_interface = {
   1 = {
     ip = ["10.1.0.10"]
   }
 }
#########################################
#########################################

######Opreating System Configuration#####
#(Reference link)https://docs.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest
vm_os_simple            = "Linux"#<---- The Option to select Windows or Linux Possible values are "WindowsServer" and "Linux"
vm_os_offer           = "opensuse-leap-15-3"
vm_os_publisher         = "SUSE"
vm_os_sku               = "gen1"
#########################################
#########################################

######Only for Custom Image Reference####
vm_custom_os_id         = ""#<----(Optional) required when the custom OS is used for the deployment.
is_windows_image        = false#<----Required when the custom image is used set to "true" if the custom image is linux
#########################################
#########################################

####Virtual Machine Disk Configuration###
os_disk_type = "StandardSSD_LRS"#<----(Requires) Possible values are "StandardSSD_ZRS", "Premium_LRS", "Premium_ZRS", "StandardSSD_LRS" or "UltraSSD_LRS"
os_disk_size = 40
#Add Extra blocks if additional data disks required.

#########################################
#########################################
#####Boot Diagnostics Configuration#####
boot_diagnostics        = false #<----(required) possible input are "true" or "false"
boot_diagnostics_sa_uri = "" #<----(required when boot diag set it to true) possible input is storage account URI
