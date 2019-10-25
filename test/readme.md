Create a secret.tfvars with the following content :

    service_principal_client_id="xxxxx"
    service_principal_client_secret= "xxxxx"

and execute with

    terraform apply -var-file="secret.tfvars"

(do not commit this file (.gitignore takes care of avoid committing it))
