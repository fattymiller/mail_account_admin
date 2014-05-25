module MailAccountAdmin
  class EmailAccountsController < BaseJump::PluginsController
    load_and_authorize_resource except: [:create]

    def create
      authorize! :create, MailAccountAdmin::EmailAccount
      
      email_account = MailAccountAdmin::EmailAccount.new(email_accounts_params)
      
      respond_to do |format|
        if email_account.save(email_accounts_params)
          format.html { redirect_to [main_app, email_account], notice: 'Email account successfully created.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: email_account.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      params[:mail_account_admin_email_account].delete(:password) if params[:mail_account_admin_email_account][:password].blank?
      params[:mail_account_admin_email_account].delete(:outgoing_password) if params[:mail_account_admin_email_account][:outgoing_password].blank?
    
      respond_to do |format|
        if @email_account.update(email_accounts_params)
          format.html { redirect_to [main_app, @email_account], notice: 'Email account successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @email_account.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @email_account.expire!
      redirect_to mail_account_admin_email_accounts_path
    end

    private

    def email_accounts_params
      params.require(:mail_account_admin_email_account).permit(
        :name, :username, :password, :incoming_server, :port, :incoming_requires_ssl, 
        :outgoing_username, :outgoing_password, :outgoing_server, :outgoing_port, :requires_authentication,
        :helo_domain, :authentication, :verify_ssl_certificate, :enable_starttls_auto, :outgoing_server_enabled)
    end
  end
end