######Virtual Machine Configuration######
vm_hostname             = "AWXWindowsTest"#<---- The host name of the Virtual machine
resource_group_name     = "RG-INFRA-AWX-TEST"#<---- The resource group where the virtual machi
location                = ""
vm_size                 = "standard_B2s"
availability_zone       = []
availability_set_id     = ""
identity_type           = "SystemAssigned"
virtual_network_name    = "AZU_APL_VNET01"
subnet_name             = "APL_SN_STG_TESTTIER"
subnet_resource_group_name = "RG-INFRA-NETWORK-01"
#existing_nic            = "/subscriptions/7c11171f-6c09-45cf-ada9-47aca93e8dde/resourceGroups/RG-Infra-Test01/providers/Microsoft.Network/networkInterfaces/testnic1"
#secondary_nic = ["/subscriptions/7c11171f-6c09-45cf-ada9-47aca93e8dde/resourceGroups/RG-Infra-Test01/providers/Microsoft.Network/networkInterfaces/testnic2"]
 extra_network_interface = {
   1 = {
     ip = ["10.91.23.148"]
   }
 }
#########################################
#########################################

######Opreating System Configuration#####
#(Reference link)https://docs.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest
vm_os_simple            = "WindowsServer"#<---- The Option to select Windows or Linux Possible values are "WindowsServer" and "Linux"
vm_os_offer             = "WindowsServer"
license_type            = "Windows_Server"#<---- Only set if its windows OS Possible values are "Windows_Client" and "Windows_Server"
vm_os_publisher         = "MicrosoftWindowsServer"
vm_os_sku               = "2019-datacenter-zhcn-g2"
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