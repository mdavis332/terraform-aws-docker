1. Ensure terraform binary is installed
2. Ensure RSA keypair (id_rsa and id_rsa.pub) are inside ~/.ssh/
3. Export AWS keys into environmental variables: 

```bash

export AWS_ACCESS_KEY_ID=<KEY_HERE>
export AWS_SECRET_ACCESS_KEY=<SECRET_KEY_HERE>

```

4. Initialize terraform: ``` terraform init ```
5. Terraform plan: ``` terraform plan -out=tf.plan ```
6. If above step works, Terraform apply: ``` terraform apply tf.plan ```
