variable "username" {
  default = "myusername"
}
variable "owner" {
  description = "User responsible for this cloud environment, resources will be tagged with this"
}

variable "resourcegroup" {
  description = "The name of the resource group."
}

variable "location" {
  default     = "eastus"
  description = "The location."
}

variable "environment" {
  description = "The environment, i.e. staging, prod, dev, etc."
}
variable "cpu" {
  default     = "0.5"
  description = "The cpu size of the container."
}

variable "memory" {
  default     = "1.5"
  description = "The memory size of the container."
}
