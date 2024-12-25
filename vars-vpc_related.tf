# VPC-related variables
variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
  default     = "vpc-0af5f0f89904ba3db"
}

variable "public_subnet_id" {
  description = "ID of the existing public subnet"
  type        = string
  default     = "subnet-05647f2ad13d0783d"
}

variable "private_subnet_id" {
  description = "ID of the existing private subnet"
  type        = string
  default     = "subnet-040df5db2be691423"
}

variable "internet_gateway_id" {
  description = "ID of the existing Internet Gateway"
  type        = string
  default     = "igw-0f73065273426bff1"
}

variable "security_group_id" {
  description = "ID of the existing security group"
  type        = string
  default     = "sg-01a79ff5dfb2fbf1e"
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed for ingress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Name = "default-natgw"
  }
}