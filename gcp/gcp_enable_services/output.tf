output "enabled_service_list" {
  value = google_project_service.services.*.id
}