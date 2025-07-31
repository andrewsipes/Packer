#Uncommment to install plugin
#packer {
#  required_version = ">= 1.12.0"
#  required_plugins {
#    vsphere = {
#      source  = "github.com/hashicorp/vsphere"
#      version = ">= 1.4.2"
#    }
#  }
#}

# LOCALS


# SOURCE

source "vsphere-iso" "linux-ubuntu-server" {

#vCenter
  vcenter_server = var.vsphere_endpoint
  username = var.vsphere_username
  password = var.vsphere.password
  datacenter = var.vsphere_datacenter
  datastore = var.vsphere_datastore
  host = var.vsphere_host
  folder = var.vsphere_folder
  insecure_connection = var.vsphere_insecure_connection
  tools_upgrade_policy = var.common_tools_upgrade_policy

#VM details
  convert_to_template = true
  guest_os_type = var.vm_guest_os_ty
  vm_version = var.guest_os_version
  vm_name = var.vm_guest_os_name
  firmware = var.vm_firmware
  CPUs = var.vm_cpu_count
  cpu_cores = var.vm_cpu_cores
  CPU_hot_plug = false
  RAM = var.vm_mem_size
  RAM_hot_plug = var.vm_mem_hot_add

#Storage
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = var.vm_disk_thin_provisioned
    disk_eagerly_scrub = false
  }

#Network
  network_adapters {
    network = var.vsphere_network
    network_card = var.vm_network_card
  }

#CD / ISO
  iso_paths = [var.iso_file]
  cd_files  = [var.vm_metadata, var.vm_userdata]
  cd_label = "cidata"
  remove_cdrom = var.common_remove_cdrom
  boot_order = "disk,cdrom"

#Boot Command - Pulled from Broadcom
  boot_command = [
    // This waits for 3 seconds, sends the "c" key, and then waits for another 3 seconds. In the GRUB boot loader, this is used to enter command line mode.
    "<wait3s>c<wait3s>",
    // This types a command to load the Linux kernel from the specified path with the 'autoinstall' option and the value of the 'data_source_command' local variable.
    // The 'autoinstall' option is used to automate the installation process.
    // The 'data_source_command' local variable is used to specify the kickstart data source configured in the common variables.
    "linux /casper/vmlinuz --- autoinstall", // ds=\"nocloud\"",
    // This sends the "enter" key and then waits. This is typically used to execute the command and give the system time to process it.
    "<enter><wait>",
    // This types a command to load the initial RAM disk from the specified path.
    "initrd /casper/initrd",
    // This sends the "enter" key and then waits. This is typically used to execute the command and give the system time to process it.
    "<enter><wait>",
    // This types the "boot" command. This starts the boot process using the loaded kernel and initial RAM disk.
    "boot",
    // This sends the "enter" key. This is typically used to execute the command.
    "<enter>"
  ]

#SSH
  ip_wait_timeout = "20m"
  ssh_password = "ubuntu"
  ssh_username = "ubuntu"
  ssh_port = 22
  ssh_timeout = "1h"
  ssh_handshake_attempts = "100"
  #shutdown_command = "echo 'ubuntu' | sudo -S -E shutdown -P now"
  shutdown_timeout = "15m"
}


# BUILD

build {
  sources = [
    "source.vsphere-iso.linux-ubuntu-server"]
  provisioner "shell" {
    execute_command = "echo 'ubuntu' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    #scripts = ["./script.sh"]
    expect_disconnect = true
  }
 }