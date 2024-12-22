# Use existing VPC, subnets, inet gateway, security group and creating new NAT gateway.
# Grouping existing subnets into public or private subnet

resource "aws_route_table" "public" {
  vpc_id = "vpc-0519cf0d7262e2722"
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = "subnet-0b98b58a183f3061a"
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-039d43164bb198ed1"
}

resource "aws_route_table" "private" {
  vpc_id = "vpc-0519cf0d7262e2722"
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = "subnet-0821ba00a02445cd4"
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group_rule" "allow_traffic" {
  security_group_id = "sg-0677d504f0e8016e5"

  # Allow SSH
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_smtp" {
  security_group_id = "sg-0677d504f0e8016e5"

  # Allow SMTP
  type        = "ingress"
  from_port   = 25
  to_port     = 25
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http" {
  security_group_id = "sg-0677d504f0e8016e5"

  # Allow HTTP
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_https" {
  security_group_id = "sg-0677d504f0e8016e5"

  # Allow HTTPS
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_icmp" {
  security_group_id = "sg-0677d504f0e8016e5"

  # Allow ICMP (ping)
  type        = "ingress"
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Create Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"  # Replacing the deprecated 'vpc = true' with 'domain = "vpc"'
}

# Create NAT Gateway in the public subnet
resource "aws_nat_gateway" "default_natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = "subnet-0b98b58a183f3061a"  # Public subnet
  tags = {
    Name = "default-natgw"
  }
}

# Update the private route table to route internet traffic through the NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default_natgw.id
}
