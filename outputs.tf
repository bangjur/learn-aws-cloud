output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "ec2_ip_list" {
  value = {
    public_ips  = [aws_instance.webapp_server1.public_ip]
    private_ips = [aws_instance.db_server1.private_ip]
  }
}