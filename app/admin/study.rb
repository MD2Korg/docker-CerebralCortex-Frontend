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


    table_for study.participants do
      column :id
      column :identifier

      column 'ECG', :id do |i|
        Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_application_id: MCerebrumApplication.where(applicationtype: 'AUTOSENSE_CHEST')))).count
      end

      column 'RIP', :id do |i|
        Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_application_id: MCerebrumApplication.where(applicationtype: 'AUTOSENSE_CHEST')))).count
      end

      column 'AutosenseWrist', :id do |i|
        Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_application_id: MCerebrumApplication.where(applicationtype: 'AUTOSENSE_WRIST')))).count
      end

      column 'MSBand', :id do |i|
        Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_application_id: MCerebrumApplication.where(applicationtype: 'MICROSOFT_BAND')))).count
      end

      # column 'Data points', :id do |dsid|
      #   Datapoint.where(datastream_id: dsid).count
      # end
      # column 'Data points (current day)', :id do |dsid|
      #   Datapoint.where(datastream_id: dsid, timestamp: (Time.now.at_beginning_of_day)..(Time.now.at_end_of_day)).count
      # end
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
