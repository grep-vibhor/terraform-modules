resource "google_project_service" "services" {
  count                      = length(var.service_name_list)
  project                    = var.project_id
  service                    = var.service_name_list[count.index]
  disable_dependent_services = var.disable_dependent_services
  disable_on_destroy         = var.disable_on_destroy
}
