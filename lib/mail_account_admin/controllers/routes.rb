Rails.application.routes.prepend do
  resources :email_accounts, controller: "mail_account_admin/email_accounts", as: :mail_account_admin_email_accounts
end