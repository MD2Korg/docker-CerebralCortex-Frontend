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

    panel '1 Hour Window' do
      table_for study.participants do
        column 'Identifier' do |i|
          link_to i.identifier, admin_participant_path(i.id)
        end

        datapoint_last_window = Datapoint.last_window((Time.now.utc-1.hours)..(Time.now.utc))

        column 'RIP', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query('DATA_QUALITY', 'RESPIRATION')))
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'ECG', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query('DATA_QUALITY', 'ECG')))
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'Wrist (L)', :id do |i|
          ds =datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query_plat_id('DATA_QUALITY', 'ACCELEROMETER', 'LEFT_WRIST')))
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'Wrist (R)', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query_plat_id('DATA_QUALITY', 'ACCELEROMETER', 'RIGHT_WRIST')))
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'EMA', :id do |i|
          ds =datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'SURVEY')))
          if ds.count > 0
            ds.count
          end
        end
      end
    end

    panel 'Current Day' do
      table_for study.participants do
        column 'Identifier' do |i|
          link_to i.identifier, admin_participant_path(i.id)
        end

        datapoint_last_window = Datapoint.last_window((Time.now.beginning_of_day)..(Time.now.end_of_day))
        column 'RIP', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query('DATA_QUALITY', 'RESPIRATION')))
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'ECG', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query('DATA_QUALITY', 'ECG')))
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'Wrist (L)', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query_plat_id('DATA_QUALITY', 'ACCELEROMETER', 'LEFT_WRIST')))
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'Wrist (R)', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query_plat_id('DATA_QUALITY', 'ACCELEROMETER', 'RIGHT_WRIST')))
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'EMA', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'SURVEY')))
          if ds.count > 0
            ds.count
          end
        end
      end
    end

    panel 'All Data' do
      table_for study.participants do
        column 'Identifier' do |i|
          link_to i.identifier, admin_participant_path(i.id)
        end

        column 'RIP', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query('DATA_QUALITY', 'RESPIRATION')))

          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'ECG', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query('DATA_QUALITY', 'ECG')))

          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'Wrist (L)', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query_plat_id('DATA_QUALITY', 'ACCELEROMETER', 'LEFT_WRIST')))

          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'Wrist (R)', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.query_plat_id('DATA_QUALITY', 'ACCELEROMETER', 'RIGHT_WRIST')))

          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'EMA', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'SURVEY')))
          if ds.count > 0
            ds.count
          end
        end

        column 'NOTIFICATIONS (O/D/T)', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'NOTIFICATION_ACKNOWLEDGE')))
          ok = ds.where("sample -> 0 ->> 'status' = 'OK'").count
          delay = ds.where("sample -> 0 ->> 'status' = 'DELAY'").count
          timeout = ds.where("sample -> 0 ->> 'status' = 'TIMEOUT'").count
          '(' + ok.to_s + '/' + delay.to_s + '/' + timeout.to_s + ')'
        end


      end
    end

    render partial: 'study', object: @study

    active_admin_comments
  end

  sidebar 'Participant details', only: :show do
    table_for study.participants do
      column 'ID' do |id|
        link_to id.id, admin_participant_path(id.id)
      end
      column :identifier
    end
  end


end
