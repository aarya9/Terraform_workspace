# Terraform_workspace codes
terraform workspace implemented 
terraform workspace --help
terraform workspace new dev
terraform workspace list
terraform workspace select dev
terraform init
terraform plan(now you can see all the default values of dev)
terraform apply --auto-approve

# Terraform_workspace code changes from old to current 
old code :

variable "gcp_region_1" {
  type="map"
  default={
      default = "us-west1"
      dev="us-central1"
      test="us-east1"
  }
}

new code (working code):

variable "gcp_region_1" {
  type=object({
    default = string
    dev=string
    test=string  
  })

  default={
      default = "us-west1"
      dev="us-central1"
      test="us-east1"
  }
}


********Basically change the map to object({....}) and add a type as string and again add defaut values down there *************very important********

2.Next add a source tag in network-firewall.tf 

old code:
resource "google_compute_firewall" "allow-http" {
  name = "${lookup(var.app_name,terraform.workspace)}-${lookup(var.app_environment,terraform.workspace)}-fw-allow-http"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol="tcp"
    ports=["80"]
  }
  target_tags = ["http"]
}

new code:
resource "google_compute_firewall" "allow-http" {
  name = "${lookup(var.app_name,terraform.workspace)}-${lookup(var.app_environment,terraform.workspace)}-fw-allow-http"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol="tcp"
    ports=["80"]
  }
  target_tags = ["http"]
  source_tags = ["mynetwork"]
}

basically i have added "source_tags = ["mynetwork"]"  to my network
