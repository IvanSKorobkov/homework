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
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "image_name" {
  type        = string
  description = "ubuntu release name"
  default     = "ubuntu-2004-lts"
}


variable "prefix_name" {
  type = map(string)
  default = {
    env     = "develop",
    project = "platform"
  }
}


variable "vm_web_name" {
  type    = string
  default = "web"
  description = "Instance name"
}

variable "vm_web_resources" { 
  type = map(number)
  default = {
    cores         = 2,
    memory        = 1,
    core_fraction = 5
  }
  description = "Costumize VM(core, RAM, core fraction)"
}


variable "vm_db_name" {
  type    = string
  default = "db"
  description = "Instance name"
}

variable "vm_db_resources" { 
  type = map(number)
  default = {
    cores         = 2,
    memory        = 2,
    core_fraction = 20
  }
  description = "Costumize VM (core, RAM, core fraction)"
}

###ssh vars


variable "vms_ssh_resources" { 
  type = map
  default = {
    serial-port-enable = 1,
    ssh-key = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrv7aN6io4UwZN/Vk0H5RxCH3FKXB3wxRKb5E8JgoKP9FXLO5QJ6vLxo5XWKB3Mw9xl3vWbkVe4TTTdyjYIXwI1sgTNv5gMSv4A5P1ZnY8EtHYmKzr2pEnk1eC7cVtTQAJqM7kdQ4XUKumtZW32EFBmBltD7suusLU+4swYLoMDcnhgjXA6VR5HprgAWmYCFsAnXdjqKiALh4d4XtkFNgsZM9rLYUYORlrlCaH141ZcpDjunGL4m3pZLU/CSZkY0ZYab7gQePlHHjqz42uy6poNbcVkSbmkEzUpX5Ko2m709ikTDDuRlORw2ss1mLGAM+xVbjXU8ZCkkNXftLE59/hRBkxK+PbIEC/40iFcsvYjNBlj4+kmiqm7gRQR6JbDDsIIPcQucjDze21+mQGGdQAO0DyOtk+XLnBleellTQTA0EioctGuei0oGfRxC+XkeDYySkQ4frJRMTi1P/NsTyrZW7HANOAcm7C0otYPMu/T+BZoXDasfKAjXV7JJOUZZ8= root@ivan"
  }
  description = "ssh-keygen -t ed25519"
}
