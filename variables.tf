variable "network_firewall_network_firewall_policy_nat_rules_lookup" {
  description = <<EOT
Map of network_firewall_network_firewall_policy_nat_rules_lookup, attributes below
Required:
    - network_firewall_policy_id
Optional:
    - display_name
    - nat_rule_priority_order
    - filter (block):
        - name (required)
        - regex (optional)
        - values (required)
EOT

  type = map(object({
    network_firewall_policy_id = string
    display_name               = optional(string)
    nat_rule_priority_order    = optional(number)
    filter = optional(list(object({
      name   = string
      regex  = optional(bool)
      values = list(string)
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.network_firewall_network_firewall_policy_nat_rules_lookup : (
        alltrue([for item in v.nat_rule_collection : (item.items == null || alltrue([for item in item.items : (item.type == null || (contains([for v in ["NATV4"] : lower(v)], lower(item.type))))]))])
      )
    ])
    error_message = "must be one of: \"NATV4\""
  }
}

