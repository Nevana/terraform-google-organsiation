terraform {
  required_version = ">=1.2.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.29.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=4.29.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.3.2"
    }
  }
}
