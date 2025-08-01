
#######################################
# DESCRIPTION:  VMware Vars File
# PURPOSE:      Initializes Values for VMware Images
# AUTHOR:       Andrew Sipes
#
# CREATED:      8/1/2025
# HISTORY:      
#
# 8/1/2025      - 1st Successful Deployment
#

#Uncommment to install plugin
packer {
  required_version = ">= 1.12.0"
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = ">= 1.4.2"
    }
  }
}

variable "vsphere_endpoint" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance."
}

variable "vsphere_username" {
  type        = string
  description = "The username to login to the vCenter Server instance."
  sensitive   = true
  default     = null
}

variable "vsphere_password" {
  type        = string
  description = "The password for the login to the vCenter Server instance."
  sensitive   = true
  default     = null
}

variable "vsphere_insecure_connection" {
  type        = bool
  description = "Do not validate vCenter Server TLS certificate."
  default     = true
}

// vSphere Settings

variable "vsphere_datacenter" {
  type        = string
  description = "The name of the target vSphere datacenter."
  default     = null
}

variable "vsphere_cluster" {
  type        = string
  description = "The name of the target vSphere cluster."
  default     = null
}

variable "vsphere_host" {
  type        = string
  description = "The name of the target ESXi host."
  default     = null
}

variable "vsphere_datastore" {
  type        = string
  description = "The name of the target vSphere datastore."
  default     = null
}

variable "vsphere_network" {
  type        = string
  description = "The name of the target vSphere network segment."
  default     = null
}

variable "vsphere_folder" {
  type        = string
  description = "The name of the target vSphere folder."
  default     = null
}

variable "vsphere_resource_pool" {
  type        = string
  description = "The name of the target vSphere resource pool."
  default     = null
}

variable "vsphere_set_host_for_datastore_uploads" {
  type        = bool
  description = "Set this to true if packer should use the host for uploading files to the datastore."
  default     = true
}

// Virtual Machine Settings

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware."
  default     = "efi-secure"
}

variable "vm_cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type."
  default     = "sata"
}

variable "vm_cdrom_count" {
  type        = string
  description = "The number of virtual CD-ROMs remaining after the build."
  default     = 1
}

variable "vm_cd_label"{
  type        = string
  description = "label for cloud init"
  default     = null
}

variable "vm_userdata" {
  type        = string
  description = "The number of virtual CD-ROMs remaining after the build."
  default     = null
}

variable "vm_metadata" {
  type        = string
  description = "The number of virtual CD-ROMs remaining after the build."
  default     = null
}

variable "vm_cpu_count" {
  type        = number
  description = "The number of virtual CPUs."
  default     = 2
}

variable "vm_cpu_cores" {
  type        = number
  description = "The number of virtual CPUs cores per socket."
  default     = 4
}

variable "vm_mem_size" {
  type        = number
  description = "The size for the virtual memory in MB."
  default     = 1024
}

variable "vm_disk_size" {
  type        = number
  description = "The size for the virtual disk in MB."
  default     = 10000
}

variable "vm_disk_controller_type" {
  type        = list(string)
  description = "The virtual disk controller types in sequence."
  default     = ["pvscsi"]
}

variable "vm_disk_thin_provisioned" {
  type        = bool
  description = "Thin provision the virtual disk."
  default     = true
}

variable "vm_network_card" {
  type        = string
  description = "The virtual network card type."
  default     = "vmxnet3"
}

variable "common_tools_upgrade_policy" {
  type        = bool
  description = "Upgrade VMware Tools on reboot."
  default     = true
}

variable "common_remove_cdrom" {
  type        = bool
  description = "Remove the virtual CD-ROM(s)."
  default     = true
}

// Template and Content Library Settings

variable "common_template_conversion" {
  type        = bool
  description = "Convert the virtual machine to template. Must be 'false' for content library."
  default     = false
}

variable "iso_file" {
  type        = string
  description = "The file name of the guest operating system ISO."
  default     = null
}

variable "iso_content_library_item" {
  type        = string
  description = "The vSphere content library item name for the guest operating system ISO."
  default     = null
}

variable "vm_boot_order" {
  type        = string
  description = "The boot order for virtual machines devices."
  default     = "disk,cdrom"
}

variable "communicator_port" {
  type        = number
  description = "The port for the communicator protocol."
  default     = 22
}

variable "communicator_timeout" {
  type        = string
  description = "The timeout for the communicator protocol."
  default     = "30m"
}

variable "vm_notes" {
  type        = string
  description = "The notes for the VM."
  default     = "Created by Packer."
}

variable "convert_to_template" {
  type        = bool
  description = "Whether to convert the VM to a template after provisioning."
  default     = true
}
