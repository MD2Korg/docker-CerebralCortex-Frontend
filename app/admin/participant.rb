ActiveAdmin.register Participant do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  permit_params :identifier

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :identifier
    end
    f.actions
  end


  show do
    attributes_table do
      row :id
      row :identifier
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  sidebar "Study details", only: :show do
    table_for participant.studies do
      column :identifier
      column :name
    end
  end

end
