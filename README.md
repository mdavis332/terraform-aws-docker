## Terraform plan to create an AWS EC2 instance that runs a docker container

### Automated terraform deployment of

1. AWS keypair
2. AWS security group
3. AWS EC2 instance

Upon which a github repo of evilginx2 is cloned and used to deploy a docker container of its app

### Getting Started

1. Ensure terraform binary is installed
2. Ensure RSA keypair (id_rsa and id_rsa.pub) are inside ~/.ssh/
3. Export AWS keys into environmental variables: 

```bash

export AWS_ACCESS_KEY_ID=<KEY_HERE>
export AWS_SECRET_ACCESS_KEY=<SECRET_KEY_HERE>

```

4. Adjust _variables.tf_
  - isp_cidr.default = "<a trusted CIDR corresponding to your ISP or netrange>"
  - aws-region.default = "<your preferred region>"
  - subnet_id.default = "<an existing subnet id within an AWS VPC that exists, to which the EC2 instance will be deployed>"
  - aws_amis.default = "<map of ami(s) by AWS region>"
  
5. Initialize terraform: ``` terraform init ```
6. Terraform plan: ``` terraform plan -out=tf.plan ```
7. If above step works, Terraform apply: ``` terraform apply tf.plan ```

### TODO

- [ ] Automate post-container startup config of evilginx2
