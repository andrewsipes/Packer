#vSphere details
vsphere_endpoint = "abrsamervcenter.corp.microsoft.com"
vsphere_username = "asipes@vsphere.local"
vsphere_password =  "Notadefaultpass!7"
vsphere_insecure_connection = true
vsphere_datacenter = "ABRS Amer Datacenter"
vsphere_host = "10.197.209.132"
vsphere_datastore = "Datastore 1"
vsphere_network = "VM_Switch_Network"
vsphere_folder = "asipes"
vsphere_set_host_for_datastore_uploads = false

#VM Details
convert_to_conversion = false
vm_guest_os_family = "linux"
vm_guest_os_type ="otherlinux64guest"
vm_guest_os_name = "RHEL96-Template"
vm_firmware = "efi"
vm_cdrom_type = "sata"
vm_cdrom_count = 1
//vm_cd_label = "cidata"
//vm_userdata = "./RHEL96/ks.cfg" # default file for user data like setting password

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
iso_file = "[Resource] ISO/rhel-9.6-x86_64-dvd.iso" #update to iso location
vm_boot_order = "disk,cdrom"
vm_boot_wait = "5s"
additional_packages = []

ip_wait_timeout = "20m"
ip_settle_timeout = "5m"
ssh_username = "redhat"
ssh_password = "redhat"
ssh_port = 22
ssh_timeout = "30m"
ssh_handshake_attempts = 100
shutdown_timeout = "15m"