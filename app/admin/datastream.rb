ActiveAdmin.register Datastream do

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

  permit_params :participant_id,
                :datasource_id

  filter :participant_id, as: :select
  filter :datasource_id, as: :select
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :participant_id, as: :search_select, url: admin_participants_path,
              fields: [:identifier], display_name: 'identifier'

      f.input :datasource_id, as: :search_select, url: admin_datasources_path,
              fields: [:identifier], display_name: 'identifier'

    end
    f.actions
  end

end
