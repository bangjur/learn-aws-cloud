# Use existing VPC, subnets, inet gateway, security group and creating new NAT gateway.
# Grouping existing subnets into public or private subnet

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group_rule" "allow_traffic" {
  security_group_id = var.security_group_id

  # Allow SSH
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_smtp" {
  security_group_id = var.security_group_id

  # Allow SMTP
  type        = "ingress"
  from_port   = 25
  to_port     = 25
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_http" {
  security_group_id = var.security_group_id

  # Allow HTTP
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_https" {
  security_group_id = var.security_group_id

  # Allow HTTPS
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_icmp" {
  security_group_id = var.security_group_id

  # Allow ICMP (ping)
  type        = "ingress"
  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "allow_alb_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]  # Allow traffic from ALB
  }
}

# Create Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"  # Replacing the deprecated 'vpc = true' with 'domain = "vpc"'
}

# Create NAT Gateway in the public subnet
resource "aws_nat_gateway" "default_natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.public_subnet_id  # Public subnet
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
