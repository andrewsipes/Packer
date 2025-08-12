#######################################
# DESCRIPTION:  Ubuntu Packer Image
# PURPOSE:      Deploys Ubuntu Packer Image
# AUTHOR:       Andrew Sipes
#
# CREATED:      8/1/2025
# HISTORY:      
#
# 8/1/2025      - 1st Successful Deployment
# 8/4/2025      - Working ufw / ssh configurations
# 8/7/2025      - Working Generalization Script

# LOCALS
locals{
  build_date        = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

# SOURCE
source "vsphere-iso" "linux-ubuntu-server" {

notes = "Built with Packer on ${local.build_date}"

#vCenter
  vcenter_server = var.vsphere_endpoint
  username = var.vsphere_username
  password = var.vsphere_password
  datacenter = var.vsphere_datacenter
  datastore = var.vsphere_datastore
  host = var.vsphere_host
  folder = var.vsphere_folder
  insecure_connection = var.vsphere_insecure_connection
  tools_upgrade_policy = var.common_tools_upgrade_policy

#VM details
  convert_to_template = var.common_template_conversion
  guest_os_type = var.vm_guest_os_type
  vm_name = var.vm_guest_os_name
  firmware = var.vm_firmware
  CPUs = var.vm_cpu_count
  cpu_cores = var.vm_cpu_cores
  RAM = var.vm_mem_size

#Storage
  disk_controller_type = var.vm_disk_controller_type
  storage {
    disk_size = var.vm_disk_size
    disk_controller_index = 0
    disk_thin_provisioned = var.vm_disk_thin_provisioned
  }

#Network
  network_adapters {
    network = var.vsphere_network
    network_card = var.vm_network_card
  }

#CD / ISO
  iso_paths = [var.iso_file]
  cd_files  = [var.vm_metadata, var.vm_userdata]
  cd_label = var.vm_cd_label
  remove_cdrom = var.common_remove_cdrom
  boot_order = var.vm_boot_order

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
  ip_wait_timeout = var.ip_wait_timeout
  ip_settle_timeout = var.ip_settle_timeout
  ssh_password = var.ssh_password
  ssh_username = var.ssh_username
  ssh_port = var.ssh_port
  ssh_timeout = var.ssh_timeout
  ssh_handshake_attempts = var.ssh_handshake_attempts
  shutdown_command = "echo ${var.ssh_password} | sudo -S -E shutdown -P now"
  shutdown_timeout = var.shutdown_timeout
}


# BUILD
build {
  sources = [
    "source.vsphere-iso.linux-ubuntu-server"]
  provisioner "shell" {
    scripts = ["./Ubuntu2204/script.sh"]
    expect_disconnect = true
  }
 }