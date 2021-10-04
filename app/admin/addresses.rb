ActiveAdmin.register Address do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :addressable_type, :addressable_id, :title, :address, :latitude, :longitude, :mobile_number, :address_type, :category, :alternative_number, :alternative_number_country_code, :mobile_number_country_code
  #
  # or
  #
  # permit_params do
  #   permitted = [:addressable_type, :addressable_id, :title, :address, :latitude, :longitude, :mobile_number, :address_type, :category, :alternative_number, :alternative_number_country_code, :mobile_number_country_code]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
