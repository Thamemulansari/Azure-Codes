######Virtual Machine Configuration######
vm_hostname             = "wndsvr"#<---- The host name of the Virtual machine
resource_group_name     = "RG-SEA-SBC-INFRA-NW-01"#<---- The resource group where the virtual machi
location                = ""
vm_size                 = "standard_d2s_v3"
identity_type           = "SystemAssigned"
virtual_network_name    = "VNET-SEA-SBC-PRD-001"
subnet_name             = "SEA-PRV-SUB-01"
extra_network_interface = {
  1 = {
    ip = ["10.123.23.124"]
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
extra_disks = {
  DataDisk1 = {#<----(required) if input is "DataDisk1" then terraform formats to <hostname>_"DataDisk1" ex.testmachine_Datadisk1
    size = 40 #<----(Required) Possible values are integers
    lun  = 0 #<----(Required) Possible values are integer (Unique for each disk)
    diskType = "Premium_LRS"#<----(Requires) Possible values are "Standard_LRS", "StandardSSD_ZRS", "Premium_LRS", "Premium_ZRS", "StandardSSD_LRS" or "UltraSSD_LRS"
    createOption = "Empty" #<----(Required) Possible values are integer "Empty" or "Copy"
    sourceResourceId = ""#<----(Optional, required when createoption set to "Copy")
    caching = "ReadWrite" #<----(Required) Possible values "None" or "ReadOnly" or "ReadWrite"
  },
  DataDisk2 = {
    size = 20
    lun  = 1
    diskType = "Premium_LRS"
    createOption = "Empty"
    sourceResourceId = ""
    caching = "ReadWrite"
  },
    DataDisk3 = {
    size = 60
    lun  = 2
    diskType = "Premium_LRS"
    createOption = "Empty"
    sourceResourceId = ""
    caching = "ReadWrite"
  }
}
#########################################
#########################################
#####Boot Diagnostics Configuration#####
boot_diagnostics        = false #<----(required) possible input are "true" or "false"
boot_diagnostics_sa_uri = "" #<----(required when boot diag set it to true) possible input is storage account URI