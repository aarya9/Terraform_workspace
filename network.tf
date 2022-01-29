resource  "google_compute_network" "vpc" {
    name ="${lookup(var.app_name,terraform.workspace)}-${lookup(var.app_environment,terraform.workspace)}-vpc"
    auto_create_subnetworks = "false"
    routing_mode = "GLOBAL"  
}

#creating public subnet
resource "google_compute_subnetwork" "public_subnet_1" {
    name = "${lookup(var.app_name,terraform.workspace)}-${lookup(var.app_environment,terraform.workspace)}-public-subnet-1"
    ip_cidr_range = lookup(var.public_subnet_cidr_1,terraform.workspace)
    network=google_compute_network.vpc.name
    region=lookup(var.gcp_region_1,terraform.workspace)
  
}

#allow internal icmp 
resource "google_compute_firewall" "allow-internal" {
    name = "${lookup(var.app_name,terraform.workspace)}-${lookup(var.app_environment,terraform.workspace)}-fw-allow-internal"
    network = "${google_compute_network.vpc.name}"
    allow {
      protocol="icmp"
    }
    allow {
      protocol="tcp"
      ports=["0-65535"]
    }
    allow {
      protocol="udp"
      ports=["0-65535"]
    }
    source_ranges = [
        "${lookup(var.public_subnet_cidr_1,terraform.workspace)}"
    ]
  
}