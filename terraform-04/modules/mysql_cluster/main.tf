resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  name        = var.cluster_name
  environment = "PRESTABLE"
  network_id  = var.network_id
  version     = "8.0"
  security_group_ids = [yandex_vpc_security_group.db_sg.id]
  
  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-hdd"
    disk_size          = 10
  }

  dynamic "host" {
    for_each = range(var.HA ? 2 : 1)
    content {
      zone = host.value == 0 ? var.zone : var.alternative_zone
      subnet_id = var.subnets[host.value == 0 ? var.zone : var.alternative_zone].id
    }
  }
}