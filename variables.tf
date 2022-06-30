variable "user_pools" {
  description = "Map of values for multi cdns"
  type = map(
    object({
      name                             = string
      adzmin_create_user_config        = any // Chek types
      alias_attributes                 = any // Chek types
      auto_verified_attributes         = any // Chek types
      email_verification_message       = any // Chek types
      email_verification_subject       = any // Chek types
      lambda_config                    = any // Chek types
      mfa_configuration                = any // Chek types
      password_policy                  = any // Chek types
      schema                           = any // Chek types
      sms_authentication_message       = any // Chek types
      sms_configuration                = any // Chek types
      sms_verification_message         = any // Chek types
      software_token_mfa_configuration = any // Chek types
      tags                             = any // Chek types
      user_pool_add_ons                = any // Chek types
      username_attributes              = any // Chek types
      username_configuration           = any // Chek types
      recovery_mechanisms              = list(string)
      allow_admin_create_user_only     = bool

      account_recovery_setting = object({
        recovery_mechanisms = list(object({
          name     = string
          priority = number
        }))
      })

      invite_message_templates = object({
        custom_email_message_template = optional(string)
        custom_email_subject_template = optional(string)
        custom_sms_message_template   = optional(string)
      })

      device_configuration = optional(object({
        challenge_required_on_new_device      = optional(bool)
        device_only_remembered_on_user_prompt = optional(bool)
      }))

      email_configuration = optional(object({
        configuration_set      = optional(string)
        email_sending_account  = optional(string)
        from_email_address     = optional(string)
        reply_to_email_address = optional(string)
        source_arn             = optional(string)
      }))

      lambda_config = optional(object({
        create_auth_challenge          = optional(string)
        custom_message                 = optional(string)
        define_auth_challenge          = optional(string)
        post_authentication            = optional(string)
        post_confirmation              = optional(string)
        pre_authentication             = optional(string)
        pre_sign_up                    = optional(string)
        pre_token_generation           = optional(string)
        user_migration                 = optional(string)
        verify_auth_challenge_response = optional(string)
        kms_key_id                     = optional(string)

        custom_sms_sender = optional(object({
          lambda_arn     = string
          lambda_version = string
        }))

        custom_email_sender = optional(object({
          lambda_arn     = string
          lambda_version = string
        }))
      }))

      password_policy = optional(object({
        minimum_length                   = optional(number)
        require_lowercase                = optional(bool)
        require_numbers                  = optional(bool)
        require_symbols                  = optional(bool)
        require_uppercase                = optional(bool)
        temporary_password_validity_days = optional(number)
      }))

      schema = optional(map(
        object({
          name                     = string
          attribute_data_type      = string
          developer_only_attribute = optional(bool)
          mutable                  = optional(bool)
          required                 = optional(bool)

          number_attribute_constraints = optional(object({
            min_value = optional(number)
            max_value = optional(number)
          }))

          string_attribute_constraints = optional(object({
            min_length = optional(number)
            max_length = optional(number)
          }))
        })
      ))
    })
  )
}

variable "user_pool_clients" {
  type = map(object({
    user_pool_id                  = string
    name                          = string
    client_id                     = string
    client_name                   = string
    client_secret                 = string
    last_modified_date            = string
    last_modified_date_time       = string
    last_modified_date_stamp      = string
    last_modified_date_time_stamp = string
    platform                      = string
    explicit_auth_flows           = list(string)
    supported_identity_providers  = list(string)
    callbacks = optional(map(
      object({
        authentication_failure         = optional(string)
        default_redirect               = optional(string)
        identity_verification          = optional(string)
        post_authentication            = optional(string)
        post_confirmation              = optional(string)
        pre_authentication             = optional(string)
        pre_sign_up                    = optional(string)
        pre_token_generation           = optional(string)
        user_migration                 = optional(string)
        verify_auth_challenge_response = optional(string)
      })
    ))
    logouts = optional(map(
      object({
        client_id  = string
        logout_url = string
      })
    ))
    prevent_user_existence_errors = optional(string)
    read_attributes               = optional(list(string))
    refresh_token_validity        = optional(number)
    write_attributes              = optional(list(string))
  }))

  description = "(optional) describe your variable"
}

variable "tags" {
  description = "Map of Tags to apply on all resources"
  type        = map(any)
  default     = {}
}
