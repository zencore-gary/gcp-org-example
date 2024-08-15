# TFLint configuration

config {
  varfile          = ["terraform.tfvars"]
  variables        = []
  call_module_type = "all"
}

plugin "terraform" {
  enabled = true
  preset  = "all"
}

plugin "google" {
  enabled = true
  version = "0.28.0"
  source  = "github.com/terraform-linters/tflint-ruleset-google"
}
