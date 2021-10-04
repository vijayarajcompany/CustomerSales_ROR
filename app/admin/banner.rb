ActiveAdmin.register Banner do
  permit_params :id, :avatar
  jcropable

  show do
    attributes_table do
      row :id
      row :avatar do |ad|
        image_tag ad.avatar_url
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Details" do
      if f.object.new_record?
        f.input :avatar
      else
        f.input :avatar, as: :jcropable, jcrop_options: {aspectRatio: 1, showDimensions: true}
      end
      li "<img src='#{f.object.avatar_url}' alt='Italian Trulli'>".html_safe unless f.object.new_record?
    end
    f.actions
  end
end
