# Used to separate the resources in this policy from other policies created
# with this module
variable "basename" {
  type    = string
  default = "seven-daily"
}

# Human-readable description of this policy
variable "description" {
  type    = string
  default = "Lifecycle policy for fast recovery"
}

# Schedule settings
variable "schedule_name" {
  type    = string
  default = "1 week of daily snapshots"
}

variable "create_interval" {
  type    = number
  default = 24
}

variable "interval_unit" {
  type    = string
  default = "HOURS"
}

variable "times" {
  type    = list(string)
  default = ["02:00"]
}

variable "retain_count" {
  type    = number
  default = 7
}

variable "target_tag_value" {
  type    = string
  default = "seven-daily"
}
