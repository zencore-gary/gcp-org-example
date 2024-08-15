locals {
  default_exclusions = [
    {
      name        = "exclude_gke_metadata"
      description = "Exclude logs from gke-metadata-server containers"
      filter      = "resource.labels.container_name=\"gke-metadata-server\""
    },
    {
      name        = "exclude_custom_stackdriver_adapter"
      description = "Exclude noisy errors from pod-custom-metrics-stackdriver-adapter containers"
      filter      = "resource.labels.container_name=\"pod-custom-metrics-stackdriver-adapter\""
    },
    {
      name        = "exclude_gce_instance_group_manager"
      description = "Exclude GCE instance group manager logs"
      filter      = "resource.type=\"gce_instance_group_manager\""
    },
    {
      name        = "exclude_k8s_composer"
      description = "Exclude k8s and Cloud Composer system logs"
      filter      = "resource.type=\"cloud_composer_environment\" OR protoPayload.serviceName=~\"k8s.io\""
    }
  ]
}
