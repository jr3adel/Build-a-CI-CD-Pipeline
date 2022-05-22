# Create an EC2 Instance and Install Apache Server on it 
resource "aws_instance" "web" {
  ami           = var.ami_image
  instance_type = "t3.micro"
  key_name = var.key_pem

  network_interface {
    device_index = 0 
    network_interface_id = aws_network_interface.nci.id
  }
  user_data = <<-EOF
                #!/bin/bash
                sudo apt update 
                sudo apt install apache2 
                sudo service apache2 start 
                echo "Welcome To Our Apache Webserver" > /var/www/html/index.html
                EOF

}
