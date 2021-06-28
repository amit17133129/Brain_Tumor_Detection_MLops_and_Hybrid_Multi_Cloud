resource "aws_vpc" "vpc" {
  count                = terraform.workspace == "aws_prod" ? 1 : 0
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Environment = "${var.environment_tag}"
    Name        = "TerraformVpc"
  }
}

resource "aws_subnet" "subnet_public1_Lab1" {
  count                   = terraform.workspace == "aws_prod" ? 1 : 0
  vpc_id                  = aws_vpc.vpc[count.index].id
  cidr_block              = var.cidr_subnet1
  map_public_ip_on_launch = "true"
  availability_zone       = element(var.az, count.index)
  tags = {
    Environment = "${var.environment_tag}"
    Name        = element(var.subnet_names, count.index) #"TerraformPublicSubnetLab1"
  }

}

resource "aws_security_group" "TerraformSG" {
  count  = terraform.workspace == "aws_prod" ? 1 : 0
  name   = "TerraformSG"
  vpc_id = aws_vpc.vpc[count.index].id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = "${var.environment_tag}"
    Name        = "TerraformSG"
  }

}
resource "aws_internet_gateway" "gw" {
  count  = terraform.workspace == "aws_prod" ? 1 : 0
  vpc_id = aws_vpc.vpc[count.index].id

  tags = {
    Name = "Terraform_IG"
  }
}
resource "aws_route_table" "r" {
  count  = terraform.workspace == "aws_prod" ? 1 : 0
  vpc_id = aws_vpc.vpc[count.index].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw[count.index].id
  }
  tags = {
    Name = "TerraformRouteTable"
  }
}
resource "aws_route_table_association" "public" {
  count          = terraform.workspace == "aws_prod" ? 1 : 0
  subnet_id      = aws_subnet.subnet_public1_Lab1[count.index].id
  route_table_id = aws_route_table.r[count.index].id
}





resource "aws_instance" "master" {
  count = terraform.workspace == "aws_prod" ? 1 : 0

  ami           = lookup(var.image, terraform.workspace)
  instance_type = lookup(var.master_node, terraform.workspace)

  availability_zone      = element(var.az, count.index)
  subnet_id              = aws_subnet.subnet_public1_Lab1[count.index].id
  vpc_security_group_ids = [aws_security_group.TerraformSG[count.index].id]
  key_name               = "key000000"
  tags = {
    Environment = var.environment_tag
    Name        = var.os_names[1]

  }
}

resource "aws_instance" "slave1" {
  count = terraform.workspace == "aws_prod" ? 1 : 0

  ami           = lookup(var.image, terraform.workspace)
  instance_type = lookup(var.type, terraform.workspace)

  availability_zone      = element(var.az, count.index)
  subnet_id              = aws_subnet.subnet_public1_Lab1[count.index].id
  vpc_security_group_ids = [aws_security_group.TerraformSG[count.index].id]
  key_name               = "key000000"
  tags = {
    Environment = var.environment_tag
    Name        = var.os_names[2]

  }
}

resource "aws_instance" "slave2" {
  count = terraform.workspace == "aws_prod" ? 1 : 0

  ami           = lookup(var.image, terraform.workspace)
  instance_type = lookup(var.type, terraform.workspace)

  availability_zone      = element(var.az, count.index)
  subnet_id              = aws_subnet.subnet_public1_Lab1[count.index].id
  vpc_security_group_ids = [aws_security_group.TerraformSG[count.index].id]
  key_name               = "key000000"
  tags = {
    Environment = var.environment_tag
    Name        = var.os_names[3]

  }
}



resource "aws_instance" "Ansible_controller_node" {
  count = terraform.workspace == "aws_prod" ? 1 : 0

  ami           = lookup(var.image, terraform.workspace)
  instance_type = lookup(var.type, terraform.workspace)

  availability_zone      = element(var.az, count.index)
  subnet_id              = aws_subnet.subnet_public1_Lab1[count.index].id
  vpc_security_group_ids = [aws_security_group.TerraformSG[count.index].id]
  key_name               = "key000000"
  tags = {
    Environment = var.environment_tag
    Name        = var.os_names[0]

  }

  provisioner "file" {
    source      = "D://Users/Amit/Desktop/k8s cluster/master/main1.yml"
    destination = "/home/ec2-user/main1.yml"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }
  provisioner "file" {
    source      = "D://Users/Amit/Desktop/k8s cluster/slave/main2.yml"
    destination = "/home/ec2-user/main2.yml"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }

  provisioner "file" {
    source      = "D://Users/Amit/Desktop/k8s cluster/ec2.py"
    destination = "/home/ec2-user/ec2.py"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }

  provisioner "file" {
    source      = "D://Users/Amit/Desktop/k8s cluster/ec2.ini"
    destination = "/home/ec2-user/ec2.ini"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }
  provisioner "file" {
    source      = "D://Users/Amit/Desktop/k8s cluster/ansible.cfg"
    destination = "/home/ec2-user/ansible.cfg"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }

  provisioner "file" {
    source      = "D://Users/Amit/Desktop/k8s cluster/key000000.pem"
    destination = "/home/ec2-user/key000000.pem"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }

  provisioner "file" {
    source      = "D://Users/Amit/Desktop/k8s cluster/aws_main.sh"
    destination = "/home/ec2-user/aws_main.sh"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }
  provisioner "file" {
    source      = "D://Users/Amit/Desktop/k8s cluster/mainplaybook.yml"
    destination = "/home/ec2-user/mainplaybook.yml"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }

    inline = [
      "sudo sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y",
      "sudo sudo yum install ansible -y",
      "sudo yes | cp /home/ec2-user/ansible.cfg   /etc/ansible/ansible.cfg",
      "sudo yum install java-1.8.0-openjdk-devel -y",
      "sudo yum install git -y",
      "sudo pip3 install boto boto3",
      "sudo mkdir /my_inventory",
      "sudo yum install wget -y",
      "sudo mv  /home/ec2-user/ec2.ini  /my_inventory/",
      "sudo mv  /home/ec2-user/ec2.py  /my_inventory/",
      "sudo chmod  +x /my_inventory/ec2.py",
      "sudo chmod  +x /my_inventory/ec2.ini",
      "sudo mv /home/ec2-user/ansible.cfg   /etc/ansible/ansible.cfg",
      "sudo export AWS_REGION='ap-south-1'",
      "sudo export AWS_ACCESS_KEY='AKIAWTVT3K2VOWVIYYGY'",
      "sudo export AWS_ACCESS_SECRET_KEY='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'",
      "chmod  400 /home/ec2-user/key000000.pem",
      "sudo ansible all -m ping",
      "sudo ansible-galaxy init /home/ec2-user/master",
      "sudo ansible-galaxy init /home/ec2-user/slave",
      "sudo  mv /home/ec2-user/main1.yml   /home/ec2-user/master/tasks/main.yml",
      "sudo  mv /home/ec2-user/main2.yml   /home/ec2-user/slave/tasks/main.yml",
      "sudo  ansible-playbook   /home/ec2-user/mainplaybook.yml"
    ]
  }

}


