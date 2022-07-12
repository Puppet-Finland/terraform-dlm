# terraform-dlm

Terraform module for managing Amazon EC2 Data Life-cycle Manager ("DLM").
With the default settings seven daily backups are retained for all EBS volumes that have tag
"dlm-lifecycle-policy: seven-daily" set.

    module "dlm-seven-weekly" {
      source           = "<url-of-this-module>"
      basename         = "seven-daily"
      target_tag_value = "seven-daily"
    }

To automatically back up an EBS volume you need to add tag
{ "dlm-lifecycle-policy": "mytag" } to it, where *mytag* should match the
value of the *target_tag_value* parameter.

See [input.tf](input.tf) to see how you can customize the tags to target,
schedules and retaining policies.
