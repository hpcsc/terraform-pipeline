provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-pipeline-state"
    region         = "ap-southeast-1"
    dynamodb_table = "tf-state-lock"
  }
}

data "aws_ami" "nginx_ami" {
  most_recent = true

  filter {
    name = "nginx-terraform-pipeline-${var.packer_build_number}"
  }

  owners = ["self"]
}

resource "aws_instance" "nginx_server" {
  ami                    = "${data.aws_ami.nginx_ami.id}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.nginx_security_group.id}"]
  key_name               = "hpcsc-terraform"

  tags {
    Name      = "terraform-example-${var.server_name}"
    CreatedBy = "Terraform"
  }
}
