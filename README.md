# terraform-pipeline

this repository is part of Terraform pipeline demonstration for my blog post at [Terraform Pipeline](https://pnguyen.io/posts/terraform-pipeline)

Organization:

- `terraform-commit.gocd.yaml`: GoCD pipeline definition for TerraformCommit pipeline
- `global/s3-state`: Terraform files to create Terraform state backend in S3
- `modules/nginx`: Terraform files to create EC2 instance with Nginx installed
- `scripts`: scripts used by GoCD pipeline
