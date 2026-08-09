variable "policies" {
  type = map(object({
    resource_group_name = string
    allowed_resource_types = list(string)
  }))
}