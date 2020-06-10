variable "workspace_name" {
 description = "Friendly name for terraform workspace"
 type = string
}

variable "repo_name" {
  description = "The GitHub relative path to the Terraform Repository"
  type = string
}

variable "component_path" {
  description = "The path within the repository where the code is stored for this particular"
  default = "/"
}

