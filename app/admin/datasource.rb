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

  preserve_default_filters!
  remove_filter :datastream


  index do
    selectable_column
    id_column

    column :identifier
    column :datasourcetype

    column "Application" do |i|
      i.m_cerebrum_application.display_name
    end
    column "Platform" do |i|
      i.m_cerebrum_platform.display_name
    end
    column "Platform App" do |i|
      i.m_cerebrum_platform_app.display_name
    end
    column 'Datastream count' do |ds|
      Datastream.where(datasource_id: ds.id).count
    end
    column 'Datapoint count' do |ds|
      Datapoint.where(datastream_id: Datastream.where(datasource_id: ds.id).collect(&:id)).count

    end
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :identifier
      f.input :datasourcetype
      f.input :datadescriptor, as: :text
      f.input :metadata, as: :text

      f.input :m_cerebrum_application_id, as: :search_select, url: admin_m_cerebrum_applications_path,
              fields: [:identifier], display_name: 'identifier'

      f.input :m_cerebrum_platform_id, as: :search_select, url: admin_m_cerebrum_platforms_path,
              fields: [:identifier], display_name: 'identifier'

      f.input :m_cerebrum_platform_app_id, as: :search_select, url: admin_m_cerebrum_platform_apps_path,
              fields: [:identifier], display_name: 'identifier'
    end
    f.actions
  end

  sidebar "Datasource", only: :show do
    table_for Datastream.where(datasource_id: datasource.id) do
      column 'Participants', :participant_id do |pid|
        Participant.find_by_id(pid.participant_id).display_name
      end
    end
  end


end
