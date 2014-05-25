class MailAccountAdmin::EmailAccountViewModel < BaseJump::ViewModel::Base
  
  def form_fields
    groups = []
    
    groups << build_fields("General information", :name)
    
    groups << build_fields("Incoming connection information", :incoming_server, :port)
    groups << build_fields(false, :username, :password, :incoming_requires_ssl)
    
    groups << build_fields("Outgoing connection information", :outgoing_server_enabled, :outgoing_server, :outgoing_port)
    groups << build_fields(false, :requires_authentication, :outgoing_username, :outgoing_password, :authentication)
    
    groups << build_fields("Miscellaneous connection information", :helo_domain, :verify_ssl_certificate, :enable_starttls_auto)
  end
  
  def incoming_requires_ssl_options(field_name, nested_under)
    { label: "Requires SSL" }
  end
  def incoming_server_options(field_name, nested_under)
    { label: "Server address", hint: "Must be a POP3 account" }
  end

  def outgoing_server_enabled_options(field_name, nested_under)
    { label: "Can send" }
  end
  def outgoing_server_options(field_name, nested_under)
    { label: "Server address" }
  end
  def outgoing_username_options(field_name, nested_under)
    { label: "Username" }
  end
  def outgoing_password_options(field_name, nested_under)
    { label: "Password", hint: "Leave blank to use incoming server details" }
  end
  def outgoing_port_options(field_name, nested_under)
    { label: "Port" }
  end
  def authentication_options(field_name, nested_under)
    { label: "Authentication type", collection: ['plain', 'login', 'cram_md5'] }
  end
  
  def verify_ssl_certificate_options(field_name, nested_under)
    { label: "Verify SSL certificate" }
  end
  def enable_starttls_auto_options(field_name, nested_under)
    { label: "Encrypt credentials" }
  end
  def helo_domain_options(field_name, nested_under)
    { label: "HELO Domain" }
  end
  
  def password_format_method(email_account, password)
    show_page? ? "<small>#{password.blank? ? "Empty" : "Hidden"}</small>".html_safe : nil
  end
  def outgoing_password_format_method(email_account, outgoing_password)
    show_page? ? "<small>#{outgoing_password.blank? ? "Empty" : "Hidden"}</small>".html_safe : nil
  end
  
end