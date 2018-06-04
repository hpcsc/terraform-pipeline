output "server_public_ip" {
  value = "${aws_instance.nginx_server.public_ip}"
}

output "server_private_ip" {
  value = "${aws_instance.nginx_server.private_ip}"
}
