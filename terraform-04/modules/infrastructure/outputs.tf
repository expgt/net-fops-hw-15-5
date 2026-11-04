output "bucket_name" {
  value       = yandex_storage_bucket.state_bucket.bucket
  description = "bucket name"
}

output "access_key_id" {
  value       = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  description = "Access Key ID"
}

output "secret_key" {
  value       = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  description = "Secret Key"
  sensitive   = true
}

output "backend_config_example" {
  description = "backend configurations for the main project"
  value       = <<EOF
terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "${yandex_storage_bucket.state_bucket.bucket}"
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
EOF
}