# Required variables (defined in terraform.tfvars)
variable "auto_join_subscription_id" {
  type = "string"
}

variable "auto_join_client_id" {
  type = "string"
}

variable "auto_join_client_secret" {
  type = "string"
}

variable "auto_join_tenant_id" {
  type = "string"
}

# Optional variables
variable "consul_version" {
  default     = "1.2.2"
  description = "Consul version to use"
}

variable "cluster_size" {
  default     = "3"
  description = "Number of instances to launch in the cluster"
}

variable "consul_vm_size" {
  default     = "Standard_A0"
  description = "Azure virtual machine size for Consul cluster"
}

variable "os" {
  # Case sensitive
  # As of 20-JUL-2017, the RHEL images on Azure do not support cloud-init, so
  # we have disabled support for RHEL on Azure until it is available.
  # https://docs.microsoft.com/en-us/azure/virtual-machines/linux/using-cloud-init
  default = "ubuntu"

  description = "Operating System to use (only 'ubuntu' for now)"
}

variable "private_key_filename" {
  default     = "private_key.pem"
  description = "Name of the SSH private key"
}

# Outputs

output "jumphost_chinaeast2_ssh_connection_strings" {
  value = "${formatlist("ssh-add %s && ssh -A -i %s %s@%s", var.private_key_filename, var.private_key_filename, module.network_chinaeast2.jumphost_username, module.network_chinaeast2.jumphost_ips_public)}"
}

output "consul_private_ips_chinaeast2" {
  value = "${formatlist("ssh %s@%s", module.consul_azure_chinaeast2.os_user, module.consul_azure_chinaeast2.consul_private_ips)}"
}
