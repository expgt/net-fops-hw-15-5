resource "yandex_iam_service_account" "sa" {
  name        = "remote-state-sa"
  description = "Service account for reading and writing tfstate in an S3 bucket"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_storage_editor" {
  folder_id = data.yandex_resourcemanager_folder.current.id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

data "yandex_resourcemanager_folder" "current" {
  folder_id = var.folder_id
}

resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "Static key"
  depends_on         = [yandex_resourcemanager_folder_iam_member.sa_storage_editor]
}

resource "yandex_storage_bucket" "state_bucket" {
  # access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  # secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  bucket     = var.bucket_name
  folder_id  = var.folder_id

  versioning {
    enabled = true
  }

  anonymous_access_flags {
    read        = false
    list        = false
    config_read = false
  }

  depends_on = [yandex_resourcemanager_folder_iam_member.sa_storage_editor]
}