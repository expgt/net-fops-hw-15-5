terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.92.0"
    }

    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = ">= 5.1.0"
    # }
    # vault = {
    #   source  = "hashicorp/vault"
    #   version = ">= 3.25.0"
    # }
  }

  required_version = "~>1.16.0"

  # backend "s3" {
  #   bucket  = "net-hw-bucket"
  #   key     = "terraform.tfstate"
  #   region  = "ru-central1"
  #   #profile = "default"
  #   encrypt = false
    
  #   # Встроенный механизм блокировок (Terraform >= 1.6)
  #   # Не требует отдельной базы данных!
  #   use_lockfile = true
    
  #   endpoints = {
  #     s3 = "https://storage.yandexcloud.net"
  #   }
    
  #   skip_region_validation      = true
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true
  #   skip_s3_checksum            = true
  # }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "hw-15-infrastructure"
    key    = "prod/terraform.tfstate"
    region = "ru-central1"

    use_lockfile = true
    use_path_style = true

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}


provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

# provider "aws" {
#   access_key                  = "mock_key"
#   secret_key                  = "mock_secret"
#   region                      = "us-east-1"
#   skip_region_validation      = true
#   skip_credentials_validation = true
#   skip_requesting_account_id  = true
#   skip_metadata_api_check     = true
# }