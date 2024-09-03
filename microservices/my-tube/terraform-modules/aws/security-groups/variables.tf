
// Security Groups Module
variable "vpc_id" {
  type = string
}

variable "public_cidr_blocks" {
  type = list(string)
}

variable "private_cidr_blocks" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

