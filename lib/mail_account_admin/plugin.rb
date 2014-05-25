require_relative "version"

require_relative "migrations/001"

module MailAccountAdmin
  class Plugin < BaseJump::Plugins::Base
    include Migrations::InitialDataSetup
    
    register "dc948911-2744-4feb-9ba3-7666bc7ba8cc", :version => MailAccountAdmin::VERSION.split(".")
  end
end

require_relative "controllers/routes"
require_relative "controllers/email_accounts_controller"

require_relative "models/email_account"
require_relative "view_models/email_account_view_model"