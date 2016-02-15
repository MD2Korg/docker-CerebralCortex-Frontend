ActiveAdmin.register Datasource do

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
                :datasourcetype,
                :datadescriptor,
                :metadata,
                :m_cerebrum_platform_app_id,
                :m_cerebrum_platform_id,
                :m_cerebrum_application_id

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :identifier
      f.input :datasourcetype
      f.input :datadescriptor, as: :text
      f.input :metadata, as: :text

      f.input :m_cerebrum_platform_app_id
      # f.input :m_cerebrum_platform_app_id, as: :search_select, url: m_cerebrum_platform_apps_path,
      #         fields: [:identifier, :platformapptype]
      f.input :m_cerebrum_platform_id
      f.input :m_cerebrum_application_id
    end
    f.actions
  end

end
