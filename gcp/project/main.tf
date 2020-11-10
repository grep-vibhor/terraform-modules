resource "google_project" "project" {
  name            = var.project_name
  project_id      = var.project_id
  org_id          = var.org_id
  billing_account = var.billing_account_id
}

data "google_iam_policy" "policy" {
  binding {
    role    = var.role_permission
    members = local.email_list
  }
  binding {
    role    = "roles/iam.serviceAccountUser"
    members = local.sa_email_list
  }
  binding {
    role    = "roles/iam.serviceAccountAdmin"
    members = local.sa_email_list
  }
  binding {
    role    = "roles/compute.admin"
    members = local.sa_email_list
  }
}

resource "google_project_iam_policy" "iam" {
  project     = google_project.project.id
  policy_data = data.google_iam_policy.policy.policy_data
}
