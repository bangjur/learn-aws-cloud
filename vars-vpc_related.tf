# VPC-related variables
variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
  default     = "vpc-024eb77936e8ddb2a"
}

variable "public_subnet_id" {
  description = "ID of the existing public subnet"
  type        = string
  default     = "subnet-06ece64e31f21a883"
}

variable "private_subnet_id" {
  description = "ID of the existing private subnet"
  type        = string
  default     = "subnet-04f85e27e3229f5a4"
}

variable "internet_gateway_id" {
  description = "ID of the existing Internet Gateway"
  type        = string
  default     = "igw-0ae4ddf6a254646aa"
}

variable "security_group_id" {
  description = "ID of the existing security group"
  type        = string
  default     = "sg-00c791f57bfd7a5b3"
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