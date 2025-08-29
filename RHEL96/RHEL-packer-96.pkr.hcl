#######################################
# DESCRIPTION:  RHEL 9.6 Packer Image
# PURPOSE:      Deploys RHEL 9.6 Packer Image
# AUTHOR:       Andrew Sipes
#
# CREATED:      8/20/2025
# HISTORY:    
#  
# 8/29/2025     -Install completes
#


# LOCALS
locals{
  build_date        = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

# SOURCE
source "vsphere-iso" "linux-rhel" {

notes = "Built with Packer on ${local.build_date}\nDefault Username: redhat\nDefault Password: redhat\nInstructions: Login and Update Hostname and password!"

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
  remove_cdrom = var.common_remove_cdrom
  boot_order = var.vm_boot_order
  http_directory = var.vm_http_directory

#Boot Command - Pulled from Broadcom

  boot_command = [
    // This sends the "up arrow" key, typically used to navigate through boot menu options.
    "<up>",
    // This sends the "e" key. In the GRUB boot loader, this is used to edit the selected boot menu option.
    "e",
    // This sends two "down arrow" keys, followed by the "end" key, and then waits. This is used to navigate to a specific line in the boot menu option's configuration.
    "<down><down><end><wait>",
    // This types the string "text" followed by the value of the 'data_source_command' local variable.
    // This is used to modify the boot menu option's configuration to boot in text mode and specify the kickstart data source configured in the common variables.
    //"text inst.ks=cdrom:/ks.cfg",
    "linux inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
    // This sends the "enter" key, waits, turns on the left control key, sends the "x" key, and then turns off the left control key. This is used to save the changes and exit the boot menu option's configuration, and then continue the boot process.
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
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
    "source.vsphere-iso.linux-rhel"]
  provisioner "shell" {
    scripts = ["./RHEL96/script.sh"]
    expect_disconnect = true
  }
 }
