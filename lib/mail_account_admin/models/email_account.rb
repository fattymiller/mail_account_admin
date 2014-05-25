module MailAccountAdmin
  class EmailAccount < ActiveRecord::Base
    include BaseJump::Expirable
    
    scope :sendable, -> { where(outgoing_server_enabled: true) }
        
    attr_encrypted :username, :key => :username_encryption_key
    attr_encrypted :outgoing_username, :key => :username_encryption_key

    attr_encrypted :password, :key => :password_encryption_key
    attr_encrypted :outgoing_password, :key => :password_encryption_key
    
    expirable_on :lower => :available_from, :upper => :available_until
    
    def username_encryption_key
      Digest::SHA512.hexdigest(Digest::SHA512.hexdigest(encryption_key_base)).reverse
    end
    def password_encryption_key
      Digest::SHA512.hexdigest(Digest::SHA512.hexdigest(encryption_key_base).reverse)
    end
    
    def to_action_mailer
      raise "This mail account has not been activated for sending. To do so, mark outgoing_server_enabled as true." unless !!outgoing_server_enabled
      
      hash = {}
      hash[:address] = first_non_blank(outgoing_server, incoming_server)
      hash[:port] = outgoing_port if outgoing_port
      hash[:domain] = helo_domain unless helo_domain.blank?
      hash[:user_name] = first_non_blank(self.outgoing_username, self.username)
      hash[:password] = first_non_blank(self.outgoing_password, self.password)
      
      hash[:authentication] = first_non_blank(authentication, 'plain').to_s
      hash[:openssl_verify_mode] = 'none' unless !!verify_ssl_certificate
      hash[:enable_starttls_auto] = !!enable_starttls_auto
      
      hash
    end
        
    private
        
    def encryption_key_base
      Rails.application.config.secret_key_base.to_s.reverse
    end
    def first_non_blank(*items)
      items.select { |s| !s.blank? }.first
    end
    
  end
end