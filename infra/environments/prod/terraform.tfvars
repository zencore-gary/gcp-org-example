# Org: blockapt.com
# Folder name: dev
parent_folder   = "folders/827348953413"
billing_account = "01F193-5E385D-24EB6F"

prefix      = "blockapt"
environment = "prod"

regions = [{
  name               = "euw1"
  region             = "europe-west1" # Belgium
  cidr               = "10.0.0.0/18"
  master             = "10.0.64.0/28"
  secondary_pods     = "10.0.128.0/18"
  secondary_services = "10.0.192.0/18"
}]

shared_project_id = "blockapt-shared-14b96d25"
parent_zone       = "blockapt-shared"
parent_domain     = "blockapt.com"
