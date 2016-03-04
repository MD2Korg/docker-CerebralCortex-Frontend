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
      column 'Identifier' do |i|
        link_to i.identifier, admin_participant_path(i.id)
      end


      column 'RIP', :id do |i|
        good=Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_CHEST')))).where("sample ->> 0 = '0'").count
        bad=Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_CHEST')))).where("sample ->> 0 != '0'").count
        (good.to_f/(good+bad)).round(3).to_s
      end
      column 'RIP(1h)', :id do |i|
        good=Datapoint.where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc), datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_CHEST')))).where("sample ->> 0 = '0'").count
        bad=Datapoint.where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc), datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_CHEST')))).where("sample ->> 0 != '0'").count
        (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + bad.to_s + ')'
      end

      column 'ECG', :id do |i|
        good=Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_CHEST')))).where("sample ->> 1 = '0'").count
        bad=Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_CHEST')))).where("sample ->> 1 != '0'").count
        (good.to_f/(good+bad)).round(3).to_s
      end
      column 'ECG(1h)', :id do |i|
        good=Datapoint.where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc), datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_CHEST')))).where("sample ->> 1 = '0'").count
        bad=Datapoint.where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc), datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_CHEST')))).where("sample ->> 1 != '0'").count
        (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + bad.to_s + ')'
      end

      column 'Wrist (AS)', :id do |i|
        good=Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_WRIST')))).where("sample ->> 0 = '0'").count
        bad=Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_WRIST')))).where("sample ->> 0 != '0'").count
        (good.to_f/(good+bad)).round(3).to_s
      end
      column 'Wrist (AS)(1h)', :id do |i|
        good=Datapoint.where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc), datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_WRIST')))).where("sample ->> 0 = '0'").count
        bad=Datapoint.where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc), datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'AUTOSENSE_WRIST')))).where("sample ->> 0 != '0'").count
        (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + bad.to_s + ')'
      end

      column 'Wrist (MS)', :id do |i|
        good=Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'MICROSOFT_BAND')))).where("sample ->> 0 = '0'").count
        bad=Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'MICROSOFT_BAND')))).where("sample ->> 0 != '0'").count
        (good.to_f/(good+bad)).round(3).to_s
      end
      column 'Wrist (MS)(1h)', :id do |i|
        good=Datapoint.where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc), datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'MICROSOFT_BAND')))).where("sample ->> 0 = '0'").count
        bad=Datapoint.where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc), datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'STATUS', m_cerebrum_platform_id: MCerebrumPlatform.where(platformtype: 'MICROSOFT_BAND')))).where("sample ->> 0 != '0'").count
        (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + bad.to_s + ')'
      end
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
