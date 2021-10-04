ActiveAdmin.register Subcategory do

  permit_params :position, :name, :quantity, :category_id, :promotion_id, :trade_offer_id, image_attributes: [:id, :avatar, :_destroy ]

  show do
    attributes_table do
      row :id
      row :name
      row :quantity
      row :image do |ad|
        image_tag ad.image&.avatar_url if ad.image.present?
      end
      row :position
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
      f.input :quantity
      f.input :position
      f.input :category_id, :label => 'Category', :as => :select, :collection => Category.all.map{|u| [u.name, u.id]}
      f.input :promotion_id, :label => 'Promotion', :as => :select, :collection => Promotion.all.map{|u| [u.promo_no, u.id]}
      f.input :trade_offer_id, :label => 'Trade_Offer', :as => :select, :collection => TradeOffer.all.map{|u| [u.title, u.id]}
    end
    f.actions
  end
end
