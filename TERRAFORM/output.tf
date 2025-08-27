output "application_node_public_ip" {
  description = "Public IP of the Application Node"
  value       = aws_instance.application_node.public_ip
}

output "application_node_public_dns" {
  description = "Public DNS of the Application Node"
  value       = aws_instance.application_node.public_dns
}

output "jenkins_master_public_ip" {
  description = "Public IP of the Jenkins Master Node"
  value       = aws_instance.jenkins_master.public_ip
}

output "jenkins_master_public_dns" {
  description = "Public DNS of the Jenkins Master Node"
  value       = aws_instance.jenkins_master.public_dns
}
