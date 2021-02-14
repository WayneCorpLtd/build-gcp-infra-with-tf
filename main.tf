terraform {
  required_version = ">= 0.12"
  backend "remote" {
    hostname      = "app.terraform.io"
    organization  = "WayneEnterprises"

    workspaces {
      name = "build-gcp-infra-with-tf"
    }
  }
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "3.5.0"
    }
  }
}

provider "google" {
    #credentials = "${GOOGLE_APPPLICATION_CREDENTIALS}"
    project = "zinc-fusion-288207"
    region = "us-central1"
    zone = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
    name = "terraform-instance"
    machine_type ="f1-micro"
    tags = ["web" , "dev"]
    boot_disk {
        initialize_params {
            image = "cos-cloud/cos-stable"
        }
    }

    network_interface {
        network = google_compute_network.vpc_network.name
        access_config {
        }
    }
}
