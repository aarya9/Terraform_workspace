provider "google" {
    credentials = "${file("C:/Users/ragha/Downloads/terraforn-sshkey/sshjsonkey.json")}"
    project     = "terraform-336010"
    region      = "us-central1"
    zone        = "us-central1-a"
}