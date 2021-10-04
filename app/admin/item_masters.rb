ActiveAdmin.register ItemMaster do
  permit_params  :position, :brand_id, :name, :itemcode, :itemdescription, :producthierarchy, :hierarchydesc, :itemgroup, :price, :quantity, :unitspercase, :activeitem, :distchannel, :division, :excise, :vat, item_master_categories_attributes: [:id, :category_id, :_destroy ],  item_master_subcategories_attributes: [:id, :subcategory_id, :_destroy ],  images_attributes: [:id, :avatar, :_destroy ]

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "file_upload"
  end

  collection_action :upload_csv do
    render "file_upload"
  end

  collection_action :import_csv, :method => :post do
    ItemMaster.load_imported_items(params[:file], params[:uploding_type])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  form do |f|
    f.inputs do
      f.has_many :item_master_categories, heading: 'category', allow_destroy: true do |a|
        a.input :category_id, :label => 'category', :as => :select, :collection => Category.all.map{|u| [u.name, u.id]}
      end
    end

    f.inputs do
      f.has_many :item_master_subcategories, heading: 'Subcategory', allow_destroy: true do |a|
        a.input :subcategory_id, :label => 'Subcategory', :as => :select, :collection => Subcategory.all.map{|u| [u.name, u.id]}
      end
    end

    f.inputs do
      f.has_many :images, heading: 'Images', allow_destroy: true do |a|
        a.input :avatar
      end
    end
    f.inputs 'Details' do
      [:name, :itemcode, :itemdescription, :producthierarchy, :hierarchydesc, :itemgroup, :price, :quantity, :unitspercase, :activeitem, :distchannel, :division, :excise, :vat, :brand, :position].each do |a|
        f.input a.to_sym
      end

    end
    f.actions
  end
end
