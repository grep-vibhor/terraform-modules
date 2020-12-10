# <p align="center"> Cloud Monitoring Alert Policy </p>

<p>Alerting gives timely awareness to problems in your cloud applications so you can resolve the problems quickly. </p>p>

<p>To create an alerting policy, you must describe the circumstances under which you want to be alerted and how you want to be notified. This page provides an overview of alerting policies and the concepts behind them.</p>


You can create and manage alerting policies with the Google Cloud Console, the Cloud Monitoring API, and Cloud SDK.

Each alerting policy specifies the following:

- **Conditions** that identify when a resource or a group of resources is in a state that requires you to take action. The conditions for an alerting policy are continuously monitored. You cannot configure the conditions to be monitored only for certain time periods.

- **Notifications** that are sent to let your support team know when the conditions have been met. The existing notification channels include all of the following:
  - Email
  - Cloud Mobile App
  - PagerDuty
  - SMS
  - Slack
  - Webhooks
  - Pub/Sub

  Configuring notifications is optional. For information on the available notification channels, see Notification options.

- **Documentation** that can be included in some types of notifications to help your support team resolve the issue. Configuring documentation is optional.

For more please refer [API docs](https://cloud.google.com/monitoring/api/ref_v3/rest/v3/projects.alertPolicies)

## google_monitoring_alert_policy  :alarm_clock:

This module creates multiple Cloud Monitoring Alert Policies. For detailed help, please refer the [official terraform docmentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy).  

## Requirements  :black_nib: 

### Installation Dependencies  :computer: 

- [terraform](https://www.terraform.io/downloads.html) 0.13.x
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin v2.5.x


### Enabling the Monitoring API :pencil:
Before you can use the Monitoring API, you must enable it and authorize users to access it.

[This page](https://cloud.google.com/monitoring/api/enable-api) describes how to enable and authorize use of the Monitoring API v3.


### Configure a Service Account  :book:

In order to execute this module you must have a Service Account with the following:

#### Roles  :anchor: 

- Monitoring Admin: `roles/monitoring.admin`    :cop: 


#### Service Account Credentials  :closed_lock_with_key: 

You can pass the service account credentials into this module by setting the following environment variables:

* `GOOGLE_CREDENTIALS`
* `GOOGLE_CLOUD_KEYFILE_JSON`
* `GCLOUD_KEYFILE_JSON`

See more [details](https://www.terraform.io/docs/providers/google/provider_reference.html#configuration-reference).

## Configuration  :gear: 

Use the following input parameters while using this module.

### Inputs  :electric_plug:


| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alert\_settings | Map for major alert policy settigs each of which is defined subsequently | <list> | `[]` | yes |
| alert\_settings.policy\_display\_name | A short name or phrase used to identify the policy in dashboards, notifications, and incidents. To avoid confusion, don't use the same display name for multiple policies in the same project. The name is limited to 512 Unicode characters.| string | `""` | yes |
| alert\_settings.combiner | How to combine the results of multiple conditions to determine if an incident should be opened. Possible values are `AND`, `OR`, and `AND_WITH_MATCHING_RESOURCE.` | string | `OR` | no |
| alert\_settings.conditions | A list of conditions for the policy. The conditions are combined by AND or OR according to the combiner field. If the combined conditions evaluate to true, then an incident is created. A policy can have from one to six conditions. Each configuration settings is defined below | <list> | `[{}]` | yes |
| alert\_settings.tier |  The machine type to use. | string | `"db-f1-micro"` | yes |
| alert\_settings.availability_type | The availability type for the master instance.This is only used to set up high availability for the PostgreSQL instance. Can be either `ZONAL` or `REGIONAL`.  | string | `"1ZONAL"` | no |
| alert\_settings.enabled | Whether or not the policy is enabled. The default is true. | bool | true | yes |
| alert\_settings.notification\_channles | Identifies the notification channels to which notifications should be sent when incidents are opened or closed or when new violations occur on an already opened incident. Each element of this array corresponds to the name field in each of the NotificationChannel objects that are returned from the notificationChannels.list method. The syntax of the entries in this field is `projects/[PROJECT_ID]/notificationChannels/[CHANNEL_ID]` See [more details](https://cloud.google.com/monitoring/support/notification-options) | `<list>` | [] | no |
| alert\_settings.documentation | Text Block for Documentation of Alerting Policy. This object contains the `content` and `mime\_type` fields | map | `{}` | no |
| alert\_settings.user\_labels | Custom User Labels to set on the Policy | map | `<map>` | no |
| project | Project Id for the Alert Policy | string | `<na>` | yes |
| alert\_settings.conditions.display\_name| A short name or phrase used to identify the condition in dashboards, notifications, and incidents. To avoid confusion, don't use the same display name for multiple conditions in the same policy. | string | `""` | yes |
| alert\_settings.conditions.condition\_threshold|  A condition that compares a time series against a threshold. See usage below for other options.| map | `{}` | yes |
| alert\_settings.conditions.condition\_absent| A condition that checks that a time series continues to receive new data points. | map | `{}` | no |
| alert\_settings.conditions.condition\_monitoring\_query\_language | A Monitoring Query Language query that outputs a boolean stream| map | `{}` | no |



### Outputs  :scroll:

| Name | Description |
|------|-------------|
| alert\_policy\_id | an identifier for the alert with format `{{name}}` |
| alert\_policy\_name | The unique resource name for this policy. Its syntax is: `projects/[PROJECT_ID]/alertPolicies/[ALERT_POLICY_ID]` |




## Usage  :hammer_and_wrench:


```

module "gcp_alerts" {
  source = "../modules/gcp_alerts"
  alert_settings = [
  {
    combiner = "OR"
    policy_display_name = "Policy"
    notification_channels = ["projects/<project id>/notificationChannels/<channel id>"]
    conditions = [{
      display_name = "CPU-alert"
      condition_threshold = {
        threshold_value = 0.15
        comparison = "COMPARISON_GT"
        duration = "60s"
        trigger_count = 1
        filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\" AND metric.labels.instance_name = \"<instance name>\""
      }
    }]
    enabled = true
    documentation = {
      content = "Managed Via Terraform"
      mime_type = "text/markdown"
    }
    user_labels = {
      env = "dev"
    }
  },

  {
    combiner = "OR"
    policy_display_name = "Policy Alert"
    conditions = [{
      display_name = "test-alert"
      condition_threshold = {
        threshold_value = 0.20
        comparison = "COMPARISON_GT"
        duration = "60s"
        trigger_count = 1
        filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      }
    }]
    enabled = true
    documentation = {
      content = "Managed Via Terraform"
      mime_type = "text/markdown"
    }
    user_labels = {
      env = "dev"
    }
  }
]

  project = var.provider_project
}

```

## Contributing  :open_hands: 
Pull requests are welcome. :blush: 

For major changes, please open an issue first to discuss what you would like to change. :wink:




## Contributors

[@Chirag Sharma](https://github.com/cldcvr/chirag-cldcvr)
