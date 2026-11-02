# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

# module "vpc_dev" {
#   source           = "./modules/vpc"
#   env_name         = var.env_name
#   zone             = var.default_zone
#   v4_cidr_blocks   = "10.0.1.0/24"
# }

module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = "develop"
  subnets = [
    { zone = "ru-central1-d", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-e", cidr = "10.0.2.0/24" }
  ]
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.env_name
  network_id   = module.vpc_dev.network_id
  #subnet_zones   = [var.default_zone]
  #subnet_ids   = [module.vpc_dev.subnet.id]
  subnet_zones   = ["ru-central1-d"]
  subnet_ids     = [module.vpc_dev.subnets["ru-central1-d"].id]
  instance_name  = "marketing"
  instance_count = var.instance_count
  platform       = var.platform
  image_family   = var.image_family
  public_ip      = var.public_ip

  labels = { 
    owner= var.label_owner,
    project = "marketing1"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = var.serial_port
  }

}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.env_name
  network_id   = module.vpc_dev.network_id
  #subnet_zones   = [var.default_zone]
  #subnet_ids   = [module.vpc_dev.subnet.id]
  subnet_zones   = ["ru-central1-e"]
  subnet_ids     = [module.vpc_dev.subnets["ru-central1-e"].id]
  instance_name  = "analytics"
  instance_count = var.instance_count
  platform       = var.platform
  image_family   = var.image_family
  public_ip      = var.public_ip

  labels = { 
  owner= var.label_owner,
  project = "analytics1"
    }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = var.serial_port
  }

}

# module "mysql_cluster" {
#   source       = "./modules/mysql_cluster"
#   cluster_name = "example"
#   network_id   = module.vpc_dev.network_id
#   subnets          = module.vpc_dev.subnets
#   zone             = "ru-central1-d"
#   alternative_zone = "ru-central1-e"
#   HA           = true
# }

# module "mysql_resources" {
#   source        = "./modules/mysql_db_user"
#   cluster_id    = module.mysql_cluster.cluster_id
#   db_name       = "test"
#   user_name     = "app"
#   user_password = var.db_password
# }

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  
  vars = {
    ssh_public_key = var.ssh_public_key
  }
}