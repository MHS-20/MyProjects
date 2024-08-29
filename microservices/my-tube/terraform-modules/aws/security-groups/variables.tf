
// Security Groups Module
variable "vpc_id" {
  type        = string
}

variable "public_subnet_ids" {
  type        = list(string)
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}