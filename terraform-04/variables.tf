###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

# variable "default_cidr" {
#   type        = list(string)
#   default     = ["10.0.1.0/24"]
#   description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
# }

# variable "vpc_name" {
#   type        = string
#   default     = "develop"
#   description = "VPC network&subnet name"
# }

###common vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "your_ssh_ed25519_key"
#   description = "ssh-keygen -t ed25519"
# }

###example vm_web var
# variable "vm_web_name" {
#   type        = string
#   default     = "netology-develop-platform-web"
#   description = "example vm_web_ prefix"
# }

###example vm_db var
# variable "vm_db_name" {
#   type        = string
#   default     = "netology-develop-platform-db"
#   description = "example vm_db_ prefix"
# }

variable "env_name" {
  type        = string
  default     = "develop"
  description = "env name"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "instance count"
}

variable "platform" {
  type        = string
  default     = "standard-v2"
  description = "platform"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family"
}

variable "public_ip" {
  type        = bool
  default     = true
  description = "public ip"
}

variable "label_owner" {
  type        = string
  default     = "devops"
  description = "label owner"
}

# variable "label_project" {
#   type        = string
#   default     = "netology"
#   description = "label project"
# }

variable "serial_port" {
  type        = number
  default     = 1
  description = "serial port"
}

variable "ssh_public_key" {
  type = string
  description = "ssh public key"
}

# variable "db_password" {
#   type = string
#   description = "db password"
# }