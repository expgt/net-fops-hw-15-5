terraform {
  required_providers {
    yandex = { source = "yandex-cloud/yandex" }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.1.0"
    }
  }
  required_version = "~>1.16.0"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket                      = "my-unique-develop-bucket-1gb"
    key                         = "vm/terraform.tfstate"
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket                      = "my-unique-develop-bucket-1gb"
    key                         = "vpc/terraform.tfstate"
    region                      = "ru-central1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    access_key = var.access_key_id
    secret_key = var.secret_key_id
  }
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=de7090ae115ee5059cd81053a808af079c325e01"
  env_name       = var.env_name
  instance_name  = "marketing"
  instance_count = var.instance_count
  platform       = var.platform
  image_family   = var.image_family
  public_ip      = var.public_ip
  subnet_zones   = ["ru-central1-d"]

  network_id     = data.terraform_remote_state.vpc.outputs.network_id
  subnet_ids     = [data.terraform_remote_state.vpc.outputs.subnets["ru-central1-d"].id]

  labels = { owner = var.label_owner, project = "marketing" }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = var.serial_port
  }
}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=de7090ae115ee5059cd81053a808af079c325e01"
  env_name       = var.env_name
  instance_name  = "analytics"
  instance_count = var.instance_count
  platform       = var.platform
  image_family   = var.image_family
  public_ip      = var.public_ip
  subnet_zones   = ["ru-central1-e"]

  network_id     = data.terraform_remote_state.vpc.outputs.network_id
  subnet_ids     = [data.terraform_remote_state.vpc.outputs.subnets["ru-central1-e"].id]

  labels = { owner = var.label_owner, project = "analytics" }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = var.serial_port
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = { ssh_public_key = var.ssh_public_key }
}