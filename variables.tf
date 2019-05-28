variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
    default = "terraform_key"
}
variable "public_key_path" {
    description = "Path to the public portion of the SSH key specified."
    default = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
    description = "Path to the private portion of the SSH key specified."
    default = "~/.ssh/id_rsa"
}

variable "instance_type" {
  description = "AWS server size."
  default     = "t2.micro"
}

variable "isp_cidr" {
    default = "200.155.0.0/16"
}

# must run the following cmds to set access_key and secret_key as env variables
# export AWS_ACCESS_KEY_ID="KEY_here"
# export AWS_SECRET_ACCESS_KEY='secret_key_here'
#variable "access_key" {}
#variable "secret_key" {}

variable "aws_region" {
    description = "AWS region to launch servers."
    default = "us-east-2"
}

# use specific VPC if you already have one not managed by TF
variable "subnet_id" {
  description = "ID of the AWS VPC subnet to use"
  default = "subnet-00000000"
}

# Ubuntu Server 18.04 LTS (x64)
variable "aws_amis" {
    default = {
        us-east-2 = "ami-097ebb39620d8d54b"
    }
}
