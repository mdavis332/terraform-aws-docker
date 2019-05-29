# Specify the provider and access details
provider "aws" {
    # keys set as env variables
    #access_key = "${var.access_key}"
    #secret_key = "${var.secret_key}"
    region = "${var.aws_region}"
}


# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "evilginx2" {
    name = "aws-docker-evilginx2"
    description = "Used in the terraform"

    # SSH access from known IP range
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.isp_cidr.default}"]
    }
    
    # DNS access from known IP range
    ingress {
        from_port = 53
        to_port = 53
        protocol = "udp"
        cidr_blocks = ["${var.isp_cidr.default}"]
    }

    # HTTPS access from known IP range
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.isp_cidr.default}"]
    }
    
    # HTTP access from known IP range
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.isp_cidr.default}"]
    }

    # outbound internet access
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# define AWS ssh keypair to be referenced later
resource "aws_key_pair" "tf-deployer" {
    key_name = "${var.key_name}"
    public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "evilginx2" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "ubuntu"
    type = "ssh"
    host = self.public_ip
    # The path to your private keyfile
    private_key = "${file(var.private_key_path)}"
  }

  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair you've created and downloaded
  # from the AWS console.
  #
  # https://console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:
  #
  key_name = "${var.key_name}"

  # Our Security group to allow HTTP and SSH access
  security_groups = ["${aws_security_group.evilginx2.id}"]

  # We run a remote provisioner on the instance after creating it.
  provisioner "file" {
      source = "./setup-scripts/"
      destination = "/tmp/"
  }
  provisioner "remote-exec" {
    inline = [
        "sh /tmp/docker-install.sh",
        "sudo git clone https://github.com/kgretzky/evilginx2.git /opt/evilginx2",        
        "sh /tmp/docker-build.sh",
        "sh /tmp/dns-change.sh",
        "sh /tmp/docker-run.sh"
    ]
  }
}
