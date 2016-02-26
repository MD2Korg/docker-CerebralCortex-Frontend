ActiveAdmin.register Study do

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

  permit_params :identifier,
                :name

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :identifier
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :identifier
      row :name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  sidebar "Participant details", only: :show do
    table_for study.participants do
      column :id
      column :identifier
    end
  end


end
