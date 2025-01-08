output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip

}

output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "ec2_ip_list" {
  value = {
    webserver_pub_ips  = [aws_instance.webapp_server1.public_ip]
    dbserver_priv_ips = [aws_instance.db_server1.private_ip]
  }
}

data "template_file" "nginx_default_conf" {
  template = file("./nginx_default_conf.tmpl")
  vars = {
    alb_dns_name = aws_lb.app_lb.dns_name
  }
}

resource "local_file" "nginx_default_conf" {
  content  = data.template_file.nginx_default_conf.rendered
  filename = "./playbooks/default.conf"
}
