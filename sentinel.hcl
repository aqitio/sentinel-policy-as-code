# policy "gcp-cis-7.1-kubernetes-ensure-stackdriver-logging-is-set-to-enabled-on-kubernetes-engine-clusters" {
#   source            = "https://raw.githubusercontent.com/aqitio/sentinel-policy-as-code/master/governance/kubernetes/gcp-cis-7.1-kubernetes-ensure-stackdriver-logging-is-set-to-enabled-on-kubernetes-engine-clusters/gcp-cis-7.1-kubernetes-ensure-stackdriver-logging-is-set-to-enabled-on-kubernetes-engine-clusters.sentinel"
#   enforcement_level = "advisory"
# }

# policy "gcp-cis-7.2-kubernetes-ensure-stackdriver-monitoring-is-set-to-enabled-on-kubernetes-engine-clusters" {
#   source            = "https://raw.githubusercontent.com/aqitio/sentinel-policy-as-code/master/governance/kubernetes/gcp-cis-7.2-kubernetes-ensure-stackdriver-monitoring-is-set-to-enabled-on-kubernetes-engine-clusters/gcp-cis-7.2-kubernetes-ensure-stackdriver-monitoring-is-set-to-enabled-on-kubernetes-engine-clusters.sentinel"
#   enforcement_level = "advisory"
# }

# policy "gcp-cis-7.3-kubernetes-ensure-legacy-authorization-is-set-to-disabled-on-kubernetes-engine-clusters" {
#   source            = "https://raw.githubusercontent.com/aqitio/sentinel-policy-as-code/master/governance/kubernetes/gcp-cis-7.3-kubernetes-ensure-legacy-authorization-is-set-to-disabled-on-kubernetes-engine-clusters/gcp-cis-7.3-kubernetes-ensure-legacy-authorization-is-set-to-disabled-on-kubernetes-engine-clusters.sentinel"
#   enforcement_level = "advisory"
# }

policy "gcp-cis-7.3" {
  source            = "https://raw.githubusercontent.com/aqitio/sentinel-policy-as-code/master/governance/kubernetes/gcp-cis-7.3/gcp-cis-7.3.sentinel"
  enforcement_level = "advisory"
}
