# VPC-related variables
variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
  default     = "vpc-03e79d426d8c21f1b"
}

variable "public_subnet_id" {
  description = "ID of the existing public subnet"
  type        = string
  default     = "subnet-08af9ef9d8a46bf34"
}

variable "private_subnet_id" {
  description = "ID of the existing private subnet"
  type        = string
  default     = "subnet-0ba24282bbd1b13d7"
}

variable "internet_gateway_id" {
  description = "ID of the existing Internet Gateway"
  type        = string
  default     = "igw-0c81faa0e03e7469d"
}

variable "security_group_id" {
  description = "ID of the existing security group"
  type        = string
  default     = "sg-00cf28b156e2dddda"
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