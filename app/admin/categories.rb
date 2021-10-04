ActiveAdmin.register Category do
  reorderable
  permit_params :position, :name, :division, image_attributes: [:id, :avatar, :_destroy ]
  jcropable

  show do
    attributes_table do
      row :id
      row :name
      row :division
      row :image do |ad|
        image_tag ad.image&.avatar_url if ad.image.present?
      end
      row :position
    end
    active_admin_comments
  end

  form do |f|
    inputs 'Image' do
      f.inputs '', for: [:image, f.object.image || f.object.build_image] do |i|
        if f.object.new_record?
          i.input :avatar
        else
          i.input :avatar, as: :jcropable, jcrop_options: {aspectRatio: 1, showDimensions: true}
        end
      end
      li "<img src='#{f.object.image.avatar_url}' alt='Italian Trulli'>".html_safe if f.object.image.present?
    end
    f.inputs 'Details' do
      [:name, :division, :position].each do |a|
        f.input a.to_sym
      end
    end
    f.actions
  end
end
