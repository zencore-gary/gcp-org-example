terraform {
  backend "gcs" {
    bucket = "blockapt-tf-state-2c81f5ee"
    prefix = "blockapt/marketplace"
  }
}
