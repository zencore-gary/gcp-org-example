locals {
  mysql_iam_users = [
    {
      name = "master"
      path = "blockapt/master-blockapt"
    },
    {
      name = "socket"
      path = "blockapt/socket-blockapt"
    }
  ]
}

module "cloudsql" {
  for_each = { for region in var.regions : region.name => region }

  source = "../../modules/cloudsql"

  project_id = module.project.project_id
  name       = "${var.environment}-${each.value.name}"
  prefix     = var.prefix

  region = each.value.region
  vpc    = module.network.vpc.self_link
  path   = "blockapt/mysql"
  tier   = "db-n1-standard-1"
}

# MySQL databases

resource "google_sql_database" "default" {
  for_each = { for region in var.regions : region.name => region }

  name      = "blockapt"
  project   = module.project.project_id
  instance  = module.cloudsql[each.key].name
  charset   = "utf8mb4"
  collation = "utf8mb4_unicode_ci"

  depends_on = [module.cloudsql]
}

# MySQL users for BlockAPT services

module "mysql_iam_users" {
  for_each = { for region in var.regions : region.name => region }

  source = "../../modules/cloudsql-iam-users"

  project_id = module.project.project_id
  name       = "${var.environment}-${each.key}"
  prefix     = var.prefix

  instance = module.cloudsql[each.key].name
  users    = local.mysql_iam_users

  depends_on = [module.cloudsql]
}
