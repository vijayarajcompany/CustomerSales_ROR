ActiveAdmin.register Wallet do
   permit_params :current_credit_limit, :outstanding_credit_limit, :pending_credit_limit, :user_id
end
