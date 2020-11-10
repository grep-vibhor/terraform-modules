resource "null_resource" "delay_40_seconds" {
  provisioner "local-exec" {
    command = "sleep 40"
  }
  triggers = {
    "always" = timestamp()
  }
}
resource "google_compute_address" "static" {
  count   = lookup(var.instance_details, "attach_static_ip", false) ? lookup(var.instance_details,"count",1) : 0
  name    = lookup(var.instance_details,"count",1) == 1 ? var.instance_details["name"] : "${var.instance_details["name"]}-${count.index}"
  project = var.service_project_name
}
resource "google_compute_instance" "gce_instance" {
  count        = lookup(var.instance_details,"count",1)
  name         = lookup(var.instance_details,"count",1) == 1 ?  lookup(var.instance_details, "name", "compute_instance") : "${lookup(var.instance_details, "name", "compute_instance")}-${count.index}"
  machine_type = lookup(var.instance_details, "machine_type", "n1-standard-1")
  zone         = var.instance_details["zone"]
  depends_on   = [var.instance_depends_on]
  can_ip_forward = lookup(var.instance_details,"can_ip_forward",false)
  project      = var.service_project_name

  tags = split(",", var.instance_details["network_tags"])
  boot_disk {
    initialize_params {
      image = var.instance_details["image"]
      size  = lookup(var.instance_details, "disk_size", "20")
      type  = lookup(var.instance_details, "disk_type", "pd-standard")
    }
  }
    network_interface {
    subnetwork_project = var.host_project_id
    subnetwork         = var.instance_details["subnetwork"]
    network_ip           = var.instance_details["network_ip"]

    dynamic "access_config" {
      for_each = lookup(var.instance_details, "attach_static_ip", false) ? [1] : []
      content {
        nat_ip = lookup(local.static_ip_map, var.instance_details["name"], "")
      }
    }
  }
  metadata_startup_script = file(var.instance_details["metadata_startup_script_file_path"])

  service_account {
    scopes = split(",", lookup(var.instance_details, "service_account_scopes", "compute-ro"))
  }
  #depends_on = [null_resource.delay_40_seconds]
}
