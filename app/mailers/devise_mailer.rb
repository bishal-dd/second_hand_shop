class DeviseMailer < Devise::Mailer
  default template_path: 'devise/mailer' # Set the template path

  def reset_password_instructions(record, token, opts = {})
    # Customize the email subject, recipients, content, etc.
    # You can use the provided `record`, `token`, and `opts` parameters
    opts[:subject] = 'Custom Reset Password Instructions'
    opts[:to] = record.email
    opts[:from] = 'noreply@example.com'

    super
  end
end
