variable "ssh_key" {
  type = string
}

variable "server_port" {
 description = "The port the server will use for HTTP requests"
 type = number
 default = 8080 
}

variable "instance_sku" {
  description = "The SKU indicating instance size. These can be retrieved by running Get-AzVmSize cmdlet."
  default = "Standard_F2"
}

variable "name" {
  description = "The name for the VM. Will be used as a prefix with many of the resources created."
  default = "vm1"
}

