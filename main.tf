resource "aws_cognito_user_pool" "pool" {
  for_each = var.user_pools

  name = each.value.name
  tags = merge(lookup(each.value, "tags"), { "Name" = each.value.name })

  mfa_configuration                = lookup(each.value, "mfa_configuration")
  alias_attributes                 = lookup(each.value, "alias_attributes")
  auto_verified_attributes         = lookup(each.value, "auto_verified_attributes")
  email_verification_message       = lookup(each.value, "email_verification_message")
  email_verification_subject       = lookup(each.value, "email_verification_subject")
  sms_authentication_message       = lookup(each.value, "sms_authentication_message")
  sms_verification_message         = lookup(each.value, "sms_verification_message")
  username_attributes              = lookup(each.value, "username_attributes")

  ##############################################################################
  # Required
  account_recovery_setting {
    dynamic "recovery_mechanism" {
      for_each = each.value.account_recovery_setting.recovery_mechanisms

      content {
        name     = each.value.account_recovery_setting.recovery_mechanisms.name
        priority = each.value.account_recovery_setting.recovery_mechanisms.priority
      }
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = lookup(each.value, "allow_admin_create_user_only", false)

    dynamic "invite_message_template" {
      for_each = each.value.invite_message_templates == null ? [] : [1]

      content {
        email_message = lookup(each.value, "custom_email_message_template", null)
        email_subject = lookup(each.value, "custom_email_subject_template", null)
        sms_message   = lookup(each.value, "custom_sms_message_template", null)
      }
    }
  }

  ##############################################################################
  # Optional
  dynamic "device_configuration" {
    for_each = each.value.device_configuration == null ? [] : [1]

    content {
      challenge_required_on_new_device      = lookup(each.value, "challenge_required_on_new_device")
      device_only_remembered_on_user_prompt = lookup(each.value, "device_only_remembered_on_user_prompt")
    }
  }

  dynamic "email_configuration" {
    for_each = each.value.email_configuration == null ? [] : [1]

    content {
      configuration_set      = lookup(each.value, "configuration_set")
      email_sending_account  = lookup(each.value, "email_sending_account")
      from_email_address     = lookup(each.value, "from_email_address")
      reply_to_email_address = lookup(each.value, "reply_to_email_address")
      source_arn             = lookup(each.value, "source_arn")
    }
  }

  dynamic "lambda_config" {
    for_each = each.value.lambda_config == null ? [] : [1]

    content {
      create_auth_challenge          = lookup(each.value, "create_auth_challenge")
      custom_message                 = lookup(each.value, "custom_message")
      define_auth_challenge          = lookup(each.value, "define_auth_challenge")
      post_authentication            = lookup(each.value, "post_authentication")
      post_confirmation              = lookup(each.value, "post_confirmation")
      pre_authentication             = lookup(each.value, "pre_authentication")
      pre_sign_up                    = lookup(each.value, "pre_sign_up")
      pre_token_generation           = lookup(each.value, "pre_token_generation")
      user_migration                 = lookup(each.value, "user_migration")
      verify_auth_challenge_response = lookup(each.value, "verify_auth_challenge_response")
      kms_key_id                     = lookup(each.value, "kms_key_id")

      dynamic "custom_email_sender" {
        for_each = each.value.custom_email_sender == null ? [] : [1]

        content {
          lambda_arn     = each.value.custom_email_sender.lambda_arn
          lambda_version = each.value.custom_email_sender.lambda_version
        }
      }

      dynamic "custom_sms_sender" {
        for_each = each.value.custom_sms_sender == null ? [] : [1]

        content {
          lambda_arn     = each.value.custom_sms_sender.lambda_arn
          lambda_version = each.value.custom_sms_sender.lambda_version
        }
      }
    }
  }

  dynamic "password_policy" {
    for_each = each.value.password_policy == null ? [] : [1]

    content {
      minimum_length                   = lookup(each.value.password_policy, "minimum_length")
      require_lowercase                = lookup(each.value.password_policy, "require_lowercase")
      require_numbers                  = lookup(each.value.password_policy, "require_numbers")
      require_symbols                  = lookup(each.value.password_policy, "require_symbols")
      require_uppercase                = lookup(each.value.password_policy, "require_uppercase")
      temporary_password_validity_days = lookup(each.value.password_policy, "temporary_password_validity_days")
    }
  }

  dynamic "schema" {
    for_each = each.value.schema

    content {
      name                     = schema.name
      attribute_data_type      = title(schema.attribute_data_type)
      developer_only_attribute = lookup(schema, "developer_only_attribute")
      mutable                  = lookup(schema, "mutable")
      required                 = lookup(schema, "required")

      dynamic "number_attribute_constraints" {
        for_each = title(each.value.attribute_data_type) == "Number" ? [1] : [0]

        content {
          max_value  = lookup(each.value.number_attribute_constraints, "max_value", null)
          min_value = lookup(each.value.number_attribute_constraints, "min_value", null)
        }
      }

      dynamic "string_attribute_constraints" {
        for_each = title(each.value.attribute_data_type) == "String" ? [1] : [0]

        content {
          max_length  = lookup(each.value.number_attribute_constraints, "max_value", null)
          min_length = lookup(each.value.number_attribute_constraints, "min_value", null)
        }
      }
    }
  }

  dynamic "sms_configuration" {
    for_each = each.value.sms_configuration == null ? [] : [1]

    content {
      external_id    = each.value.external_id
      sns_caller_arn = each.value.sns_caller_arn
    }
  }

  dynamic "software_token_mfa_configuration" {
    for_each = each.value.software_token_mfa_configuration == [null, false] ? [] : [1]

    content {
      enabled = each.value.software_token_mfa_configuration == true ? true : false
    }
  }

  dynamic "user_pool_add_ons" {
    for_each = each.value.user_pool_add_ons == null ? [] : [1]

    content {
      advanced_security_mode = lookup(each.value.user_pool_add_ons, "advanced_security_mode", "OFF")
    }
  }
  dynamic "username_configuration" {
    for_each = each.value.username_configuration == null ? [] : [1]

    content {
      case_sensitive = lookup(each.value.username_configuration, "case_sensitive", false)
    }
  }

  dynamic "verification_message_template" {
    for_each = each.value.verification_message_template == null ? [] : [1]

    content {
      default_email_option  = lookup(each.value, "default_email_option", null)
      email_message         = lookup(each.value, "email_message", null)
      email_message_by_link = lookup(each.value, "email_message_by_link", null)
      email_subject         = lookup(each.value, "email_subject", null)
      email_subject_by_link = lookup(each.value, "email_subject_by_link", null)
      sms_message           = lookup(each.value, "sms_message", null)
    }
  }
}

resource "aws_cognito_user_pool_client" "client" {
  for_each = var.user_pool.clients

  depends_on = [
    aws_cognito_user_pool.pool
  ]
}