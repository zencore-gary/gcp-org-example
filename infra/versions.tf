terraform {
  required_version = "~> 1.0"

  required_providers {
    # Hashicorp
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

    # Google
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
}
