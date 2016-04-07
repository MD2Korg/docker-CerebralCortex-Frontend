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

  preserve_default_filters!
  remove_filter :datapoints

  index do
    selectable_column
    id_column

    column 'Details' do |i|
      link_to "data", admin_datapoints_path(q: {datastream_id_eq: i.id})
    end

    column 'Participant' do |i|
      i.participant.display_name
    end
    column 'Datasource' do |i|
      i.datasource.display_name
    end
    column 'Application' do |i|
      i.datasource.m_cerebrum_application.display_name
    end
    column 'Platform' do |i|
      i.datasource.m_cerebrum_platform.display_name
    end
    column 'Platform App' do |i|
      i.datasource.m_cerebrum_platform_app.display_name
    end
    column 'Count' do |ds|
      ds.datapoints.count
    end
    column 'Count (last 24 hours)' do |ds|
      ds.datapoints.where(timestamp: (Time.now.utc-24.hours)..(Time.now.utc)).count
    end
    actions
  end


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
