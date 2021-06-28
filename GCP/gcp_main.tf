resource "google_compute_instance" "docker" {
  name          = "docker"
  machine_type  = lookup(var.type, terraform.workspace)
  zone          = "asia-south1-b"
  count         = terraform.workspace == "gcp_dev" ? 1 : 0
  tags          = ["ssh","http"]
  boot_disk {
    initialize_params {
      image = lookup(var.image, terraform.workspace)
    }
  }

  network_interface {
    network = "default"
    access_config {
    nat_ip = google_compute_address.static1.address
    }
  }
  provisioner "file" {
    source      = "D://Users/Amit/Desktop/BT/Dockerfile"
    destination = "/home/centos/Dockerfile"
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/new.pem")
      host        = google_compute_address.static1.address
    }
  }

    provisioner "file" {
    source      = "D://Users/Amit/Desktop/BT/app.py"
    destination = "/home/centos/app.py"
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/new.pem")
      host        = google_compute_address.static1.address
    }
  }

    provisioner "file" {
    source      = "D://Users/Amit/Desktop/BT/myform.html"
    destination = "/home/centos/myform.html"
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/new.pem")
      host        = google_compute_address.static1.address
    }
  }
    provisioner "file" {
    source      = "D://Users/Amit/Desktop/BT/results.html"
    destination = "/home/centos/results.html"
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/new.pem")
      host        = google_compute_address.static1.address
    }
  }
    provisioner "file" {
    source      = "D://Users/Amit/Desktop/BT/docker.repo"
    destination = "/home/centos/docker.repo"
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/new.pem")
      host        = google_compute_address.static1.address
    }
  }
      provisioner "file" {
    source      = "D://Users/Amit/Desktop/BT/brain_tumor_40.h5"
    destination = "/home/centos/brain_tumor_40.h5"
    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/new.pem")
      host        = google_compute_address.static1.address
    }
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "centos"
      timeout     = "500s"
      private_key = file("D://Users/Amit/Desktop/k8s cluster/new.pem")
      host        = google_compute_address.static1.address
    }

    inline = [
      "sudo touch /etc/yum.repos.d/docker.repo",
      "sudo mkdir  /root/brain_tumor",
      "sudo mv /home/centos/docker.repo    /etc/yum.repos.d",
      "sudo mv /home/centos/Dockerfile  /root/brain_tumor/",
      "sudo mv /home/centos/app.py  /root/brain_tumor/",
      "sudo mv /home/centos/myform.html  /root/brain_tumor/",
      "sudo mv /home/centos/results.html  /root/brain_tumor/",
      "sudo mv /home/centos/brain_tumor_40.h5    /root/brain_tumor/",
      "sudo yum install docker-ce  -y",
      "sudo systemctl start docker",
      "sudo docker build -t  amitsharma17133129/brain_tumor_detection_hmc_mlops1:v1  /root/brain_tumor",
      "sudo docker login -u amitsharma17133129  -p  ABdevilliers@17",
      "sudo docker push amitsharma17133129/brain_tumor_detection_hmc_mlops1:v1"
    ]
  }

 metadata = {
    "ssh-keys" = <<EOT
centos:ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAxNcSyBvW9Gfig6wW4jbO4CmTDA7sylTG4OuPwDvAsn0s5lyicuuIgi++TMs2stAgamBCp14yFk7KmIdeUc58tdkDgCaz/MBJf6odgzsocDpETFahtd3w1xQxESJrdVzJGS81LBlvngRgJ5zdiWvbrWJwUArr019gx/C9UlvUa2G+lYq5owgqAvufod8mfa0xNiZRVcZtdZV8tjjZPCeXiwSWPVenpbWWi76nPcUWUpMEoeVhgiZenHrbNZWZ4tAA6WVqBD8E4m87niLmY09t1MSnrjMX5JruXPQ4/VCwgb2zvOmcd6VlIxZjVmIbt89Gb4rdNpp/34v7RkBZCB2BzQ== centos
EOT
  }

}
resource "google_compute_address" "static1" {
  name = "ipv4-address1"
}

