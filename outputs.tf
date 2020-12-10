output "ipv4_address" {
  value = aws_instance.app-server.*.public_ip

}