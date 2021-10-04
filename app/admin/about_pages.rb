ActiveAdmin.register AboutPage do
  permit_params do
    permitted = [:content, images_attributes: [:id, :avatar, :_destroy ]]
    permitted
  end

  index do
    selectable_column
    id_column
    column :content
    column :images
    
    # column 'Images' do |about|
    #   about.images do |img|
    #     image_tag img.full_image_url(:avatar)
    #   end
    # end

    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :content
      row :images
      # row 'Image' do |about|
      #   about.images do |img|
      #     image_tag img.full_image_url(:avatar)
      #   end
      # end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :content
    end
    f.inputs do
      f.has_many :images, heading: 'Images', allow_destroy: true do |a|
        a.input :avatar
      end
    end
    f.actions
  end
end
