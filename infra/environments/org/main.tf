locals {
  labels = {
    env     = "shared"
    purpose = "blockapt"
    owner   = "zencore"
  }
}

module "shared_folder" {
  source       = "../../modules/folder"
  display_name = "shared"
  parent       = var.parent_folder
}

module "dev_folder" {
  source       = "../../modules/folder"
  display_name = "dev"
  parent       = var.parent_folder
}

module "marketplace_folder" {
  source       = "../../modules/folder"
  display_name = "marketplace"
  parent       = var.parent_folder
}
