variable "token" {
  type        = string
  description = "IAM-token"
}

variable "cloud_id" {
  type        = string
  description = "cloud id"
}

variable "folder_id" {
  type        = string
  description = "folder id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "default zone"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket"
  default     = "hw-15-infrastructure"
}