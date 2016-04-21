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

    panel 'Current Summary' do
      table_for study.participants do
        column 'Identifier' do |i|
          link_to i.identifier, admin_participant_path(i.id)
        end

        column 'Day Start', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'DAY_START')))
          if ds.present?
            Time.at(ds.last['sample'][0]/1000.0).utc.to_datetime
          end
        end
        column 'Day End', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'DAY_END')))
          if ds.present?
            Time.at(ds.last['sample'][0]/1000.0).utc.to_datetime
          end
        end

        column 'Stress Epsiodes', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'ORG_MD2K_CSTRESS_STRESS_EPISODE_CLASSIFICATION')))
          ds.count.to_s
        end

        column 'Total Payment', :id do |i|
          ds = Datapoint.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'INCENTIVE')))
          if ds.present?
            totalPayment = ds.where("sample -> 0 ? 'totalIncentive'")
            totalPayment.last['sample'][0]['totalIncentive'].to_s
            # totalPayment.to_s
          end
        end

      end
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
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'SURVEY')))
          ds.count.to_s
        end

        column 'NOTIFICATIONS (O/D/T)', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'NOTIFICATION_ACKNOWLEDGE')))
          ok = ds.where("sample -> 0 ->> 'status' = 'OK'").count
          delay = ds.where("sample -> 0 ->> 'status' = 'DELAY'").count
          timeout = ds.where("sample -> 0 ->> 'status' = 'TIMEOUT'").count
          total = ds.count
          total.to_s + ' (' + ok.to_s + '/' + delay.to_s + '/' + timeout.to_s + ')'
        end

        column 'Incentives', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'INCENTIVE')))
          total = ds.count
          total.to_s
        end

        column 'Privacy', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'PRIVACY')))
          total = ds.count
          total.to_s
        end

        column 'Smoking Self Reports', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'EVENT')))
          total = ds.where("sample -> 0 ->> 'event' = 'SMOKING'").where("sample -> 0 ->> 'type' = 'SELF_REPORT'").count
          total.to_s
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
          ds.count.to_s
        end

        column 'NOTIFICATIONS (O/D/T)', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'NOTIFICATION_ACKNOWLEDGE')))
          ok = ds.where("sample -> 0 ->> 'status' = 'OK'").count
          delay = ds.where("sample -> 0 ->> 'status' = 'DELAY'").count
          timeout = ds.where("sample -> 0 ->> 'status' = 'TIMEOUT'").count
          total = ds.count
          total.to_s + ' (' + ok.to_s + '/' + delay.to_s + '/' + timeout.to_s + ')'
        end

        column 'Incentives', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'INCENTIVE')))
          total = ds.count
          total.to_s
        end

        column 'Privacy', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'PRIVACY')))
          total = ds.count
          total.to_s
        end

        column 'Smoking Self Reports', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'EVENT')))
          total = ds.where("sample -> 0 ->> 'event' = 'SMOKING'").where("sample -> 0 ->> 'type' = 'SELF_REPORT'").count
          total.to_s
        end
      end
    end

    panel 'All Data' do
      table_for study.participants do
        column 'Identifier' do |i|
          link_to i.identifier, admin_participant_path(i.id)
        end

        datapoint_last_window = Datapoint
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
          ds.count.to_s
        end

        column 'NOTIFICATIONS (O/D/T)', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'NOTIFICATION_ACKNOWLEDGE')))
          ok = ds.where("sample -> 0 ->> 'status' = 'OK'").count
          delay = ds.where("sample -> 0 ->> 'status' = 'DELAY'").count
          timeout = ds.where("sample -> 0 ->> 'status' = 'TIMEOUT'").count
          total = ds.count
          total.to_s + ' (' + ok.to_s + '/' + delay.to_s + '/' + timeout.to_s + ')'
        end

        column 'Incentives', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'INCENTIVE')))
          total = ds.count
          total.to_s
        end

        column 'Privacy', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'PRIVACY')))
          total = ds.count
          total.to_s
        end

        column 'Smoking Self Reports', :id do |i|
          ds = datapoint_last_window.where(datastream_id: Datastream.where(participant_id: i, datasource_id: Datasource.where(datasourcetype: 'EVENT')))
          total = ds.where("sample -> 0 ->> 'event' = 'SMOKING'").where("sample -> 0 ->> 'type' = 'SELF_REPORT'").count
          total.to_s
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
