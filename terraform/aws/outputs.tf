output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.wp_instance.public_ip
}

output "db_instance_endpoint" {
  description = "DB instance Endpoint"
  value       = aws_db_instance.wp_db.endpoint
}