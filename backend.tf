terraform {
  backend s3 {
    bucket         = "my-faizan-terraform-state-bucket"
    key            = "env/dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    use_lockfile = true
  }

}