# Folder name: marketplace
parent_folder   = "folders/91937369954"
billing_account = "013DCC-26A22B-39E81F"
prefix          = "zencore"
environment     = "mp"

regions = [{
  name               = "euw1"
  region             = "europe-west1" # Belgium
  cidr               = "10.0.0.0/18"
  secondary_pods     = "10.0.64.0/18"
  secondary_services = "10.0.128.0/18"
}]

shared_project_id = "blockapt-shared-1d589eb4"
parent_domain     = "gcp.zencore.dev"
