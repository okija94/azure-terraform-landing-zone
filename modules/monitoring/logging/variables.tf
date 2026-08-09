variable "log_analytics_workspace" {
  type = map(object({
    location = string
    resource_group_name = string
  }))
  
}

