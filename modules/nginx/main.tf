provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-pipeline-state"
    key            = "modules/nginx"
    region         = "ap-southeast-1"
    dynamodb_table = "tf-state-lock"
  }
}

resource "aws_instance" "nginx_server" {
  ami                    = "ami-81cefcfd"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.nginx_security_group.id}"]
  key_name               = "hpcsc-terraform"

  tags {
    Name = "terraform-example-${var.server_name}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
    ]

    connection {
      user        = "ubuntu"
      private_key = "${file(var.private_key_path)}"
      host        = "${self.public_ip}"
    }
  }

  provisioner "file" {
    source      = "files/index.html"
    destination = "/tmp/nginx-index.html"

    connection {
      user        = "ubuntu"
      private_key = "${file(var.private_key_path)}"
      host        = "${self.public_ip}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv -f /tmp/nginx-index.html /var/www/html/index.html",
    ]

    connection {
      user        = "ubuntu"
      private_key = "${file(var.private_key_path)}"
      host        = "${self.public_ip}"
    }
  }
}
