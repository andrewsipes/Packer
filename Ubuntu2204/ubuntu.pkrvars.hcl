#######################################
# DESCRIPTION:  Ubuntu PKvars File
# PURPOSE:      Provides values to required attributes to deploy packer image
# AUTHOR:       Andrew Sipes
#
# CREATED:      8/1/2025
# HISTORY:      
#
# 8/1/2025      - 1st Successful Deployment
#

#vSphere details
vsphere_endpoint = ""
vsphere_username = ""
vsphere_password =  ""
vsphere_insecure_connection = true
vsphere_datacenter = ""
vsphere_host = ""
vsphere_datastore = ""
vsphere_network = ""
vsphere_folder = ""
vsphere_set_host_for_datastore_uploads = false

#VM Details
vm_guest_os_family = "linux"
vm_guest_os_type ="ubuntu64Guest"
vm_guest_os_name = "Ubuntu2204-Template"
vm_firmware = "efi-secure"
vm_cdrom_type = "sata"
vm_cdrom_count = 1
vm_cd_label = "cidata"
vm_userdata = "./Ubuntu2204/user-data" # default file for user data like setting password
vm_metadata = "./Ubuntu2204/meta-data" # default file for meta data - intentionally left blank

#Compute
vm_cpu_count = 2
vm_cpu_cores = 4
vm_cpu_hot_add = false
vm_mem_size = 4096
vm_mem_hot_add = false
vm_disk_size = 102400
vm_disk_controller_type = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card = "vmxnet3"
iso_file = "[Resource] ISO/ubuntu-22.04.5-live-server-amd64.iso" #update to iso location
vm_boot_order = "disk,cdrom"
vm_boot_wait = "5s"
additional_packages = []