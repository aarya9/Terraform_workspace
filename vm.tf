resource "random_id" "instance_id" {
  byte_length=4
}

resource "google_compute_instance" "vm_instance_public" {
    name="${lookup(var.app_name,terraform.workspace)}-${lookup(var.app_environment,terraform.workspace)}-vm-${random_id.instance_id.hex}"
    machine_type = "f1-micro"
    zone = lookup(var.gcp_zone_1,terraform.workspace)
    hostname="${lookup(var.app_name,terraform.workspace)}-vm-${random_id.instance_id.hex}.${lookup(var.app_domain,terraform.workspace)}"
    tags=["ssh","http"]

    boot_disk {
      initialize_params{
          image="centos-cloud/centos-7"
      }
    }
    metadata_startup_script = "sudo apt-get update; sudo apt-get install apache2"

    network_interface {
      network=google_compute_network.vpc.name
      subnetwork=google_compute_subnetwork.public_subnet_1.name
      access_config {}
    }
}