# module "s3_bucket_1gb" {
#   source      = "./modules/terraform-yc-s3"
#   bucket_name = "my-unique-develop-bucket-1gb"
#   max_size    = 1073741824
#   acl         = "private"
#   folder_id   = var.folder_id
# }

# output "bucket_domain_name" {
#   value       = module.s3_bucket_1gb.bucket_domain_name
# }