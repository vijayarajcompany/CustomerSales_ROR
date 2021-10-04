ActiveAdmin.register Division do
  permit_params :id, :name, :description, image_attributes: [:id, :avatar, :_destroy ]

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :image do |ad|
        image_tag ad.image&.avatar_url if ad.image.present?
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.has_many :image, heading: 'Images', allow_destroy: true do |a|
        a.input :avatar, as: :jcropable, jcrop_options: {aspectRatio: 1, showDimensions: true}
      end
      li "<img src='#{f.object.image.avatar_url}' alt='Italian Trulli'>".html_safe if f.object.image.present?
    end

    f.inputs 'Details' do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
