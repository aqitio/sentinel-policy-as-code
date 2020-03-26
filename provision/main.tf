variable "failure" {}

provider "google-beta" {}

resource "google_container_cluster" "this" {
  provider = "google-beta"
  name     = "this-cluster"
  location = "australia-southeast1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  #
  # 7.1 Ensure Stackdriver Logging is set to Enabled on Kubernetes Engine Clusters
  # NOTE: Can also be logging.googleapis.com
  #
  logging_service = "logging.googleapis.com/kubernetes"

  #
  # 7.2 Ensure Stackdriver Monitoring is set to Enabled on Kubernetes Engine Clusters
  # NOTE: Can also be monitoring.googleapis.com
  #
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  #
  # 7.3 Ensure Legacy Authorization is set to Disabled on Kubernetes Engine Clusters
  #
  enable_legacy_abac = var.failure

  #
  # 7.4 Ensure Master authorized networks is set to Enabled on Kubernetes Engine Clusters
  #
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/8"
      display_name = "10x"
    }
    cidr_blocks {
      cidr_block   = "172.16.0.0/12"
      display_name = "172x"
    }
    cidr_blocks {
      cidr_block   = "192.168.0.0/16"
      display_name = "192x"
    }
  }

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    #
    # 7.17 Ensure default Service account is not used for Project access in Kubernetes Clusters
    #
    service_account = "node-service-account-field"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    #
    # 7.5 Ensure Kubernetes Clusters are configured with Labels
    #
    labels = {
      foo = "bar"
    }

    #
    # 7.9 Ensure Container-Optimized OS (cos) is used for Kubernetes Engine Clusters Node image
    #
    image_type = "COS"

    #
    # 7.18 Ensure Kubernetes Clusters created with limited service account Access scopes for Project access
    #
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }



  master_auth {
    #
    # 7.10 Ensure Basic Authentication is disabled on Kubernetes Engine Clusters
    #
    username = ""
    password = ""

    #
    # 7.12 Ensure Kubernetes Cluster is created with Client Certificate enabled
    #
    client_certificate_config {
      issue_client_certificate = true
    }
  }

  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  #
  # 7.11 Ensure Network policy is enabled on Kubernetes Engine Clusters
  #
  network_policy {
    enabled = true
  }

  #
  # 7.13 Ensure Kubernetes Cluster is created with Alias IP ranges enabled
  #
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  #
  # 7.14 Ensure PodSecurityPolicy controller is enabled on the Kubernetes Engine Clusters
  #
  pod_security_policy_config {
    enabled = true
  }

  #
  # 7.15 Ensure Kubernetes Cluster is created with Private cluster enabled
  #
  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.32/28"
  }

}

resource "google_container_node_pool" "this" {
  provider   = google-beta
  name       = "this-pool"
  location   = google_container_cluster.this.location
  cluster    = google_container_cluster.this.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    #
    # 7.17 Ensure default Service account is not used for Project access in Kubernetes Clusters
    #
    service_account = "node-service-account-field"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    #
    # 7.5 Ensure Kubernetes Clusters are configured with Labels
    #
    labels = {
      foo = "bar"
    }

    #
    # 7.9 Ensure Container-Optimized OS (cos) is used for Kubernetes Engine Clusters Node image
    #
    image_type = "COS"

    #
    # 7.18 Ensure Kubernetes Clusters created with limited service account Access scopes for Project access
    #
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }

  management {
    #
    # 7.7 Ensure `Automatic node repair` is enabled for Kubernetes Clusters
    #
    auto_repair = true
    #
    # 7.8 Ensure Automatic node upgrades is enabled on Kubernetes Engine Clusters nodes
    #
    auto_upgrade = true
  }
}

resource "google_container_cluster" "minimal" {
  provider = google-beta
  name     = "minimal-cluster"
  location = "australia-southeast1"
  remove_default_node_pool = true
  initial_node_count       = 1
  node_config {
      machine_type = "n1-standard-1"
      labels = {}
  }
}
