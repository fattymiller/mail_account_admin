module MailAccountAdmin
  module Migrations
    module InitialDataSetup
      def self.included(klass)
        klass.class_eval do
          register_migrations_for [0,0,1] do |m|
            m.create_table :email_accounts do |t|
              t.string :name, :null => false
            
              t.datetime :available_from
              t.datetime :available_until
              
              t.string :encrypted_username, :null => false
              t.string :encrypted_password, :null => false
              
              t.string :encrypted_outgoing_username
              t.string :encrypted_outgoing_password
              t.boolean :requires_authentication, default: false
              
              t.string :helo_domain
              t.string :incoming_server
              t.string :outgoing_server

              t.integer :port
              t.integer :outgoing_port

              t.string :authentication # :plain, :login, :cram_md5
              t.boolean :verify_ssl_certificate, default: true
              t.boolean :enable_starttls_auto, default: true
              t.boolean :incoming_requires_ssl, default: false
              t.boolean :outgoing_server_enabled, default: false
            
              t.timestamps
            end
          end
        end
      end
    end
  end
end