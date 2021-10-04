ActiveAdmin.register User do

  show do
    attributes_table do
      User.column_names.each do |order_field|
        row order_field.to_sym
      end

      panel "Addresses" do
        table_for user.addresses do
           ["id", "addressable_type", "addressable_id", "title", "address", "latitude", "longitude", "created_at", "updated_at", "mobile_number", "address_type", "category", "alternative_number", "alternative_number_country_code", "mobile_number_country_code"].each do |a|
            column a.to_sym
          end
        end
      end

    end

    active_admin_comments
  end


  permit_params do
    permitted = [:user_type, :first_name, :last_name, :email, :company_id, :activated, :confirm_token, :reset_digest, :reset_sent_at, :ern_number, :document, :status, :created_at, :updated_at, :last_login, :profile_picture, :customercode, :route, :address1, :city, :telephone, :paymentterms, :creditlimitdays, :creditlimitamount, :activecustomer, :customergroup, :vat, :excise, :tradeoffer_id, :credit_override, :division, :confirm, :password
                 ]
    if params[:user] && params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    permitted
  end
  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "file_upload"
  end

  collection_action :import_csv, :method => :post do
    User.load_imported_items(params[:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  form do |f|
    f.inputs do
      f.semantic_errors *f.object.errors.keys
    end
    f.inputs "Update password" do
      f.input :password
    end
    # f.input :user_type, as: :select, collection: User.user_types.keys.map { |a| [a.titleize, a] }

    f.inputs
    f.actions
  end
  # controller do
  #   def update
  #     @user = User.find(params[:id])
  #     if params[:user][:password].blank?
  #       @user.update_without_password(permitted_params[:user])
  #     else
  #       @user.update_attributes(permitted_params[:user])
  #     end
  #     if @user.errors.blank?
  #       redirect_to users_path(@user), :notice => "User updated successfully."
  #     else
  #       render :edit
  #     end
  #   end
  # end
end
