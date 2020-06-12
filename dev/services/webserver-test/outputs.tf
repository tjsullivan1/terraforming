output "public_ip" {
    value = module.webserver.public_ip
    description = "The public IP address of the web server."
}