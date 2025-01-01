# VPC-related variables
variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
  default     = "vpc-08333fe118d84bed6"
}

variable "public_subnet_id" {
  description = "ID of the existing public subnet"
  type        = string
  default     = "subnet-0fcab57234617a9ac"
}

variable "private_subnet_id" {
  description = "ID of the existing private subnet"
  type        = string
  default     = "subnet-016bb8a86842b9474"
}

variable "internet_gateway_id" {
  description = "ID of the existing Internet Gateway"
  type        = string
  default     = "igw-0cda93cdb2b5fbd3b"
}

variable "security_group_id" {
  description = "ID of the existing security group"
  type        = string
  default     = "sg-087e536ef8166a5b6"
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