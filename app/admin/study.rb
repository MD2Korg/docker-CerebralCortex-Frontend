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

    ids = study.participants.pluck(:id)
    autosense_chest_list = Datastream.where(participant_id: ids, datasource_id: Datasource.query_status('STATUS', 'AUTOSENSE_CHEST'))
    autosense_wrist_list = Datastream.where(participant_id: ids, datasource_id: Datasource.query_status('STATUS', 'AUTOSENSE_WRIST'))
    microsoft_band_list = Datastream.where(participant_id: ids, datasource_id: Datasource.query_status('STATUS', 'MICROSOFT_BAND'))
    survey_list = Datastream.where(participant_id: ids, datasource_id: Datasource.query_status('STATUS', 'SURVEY'))

    panel "1 Hour Window" do

      table_for study.participants do
        column 'Identifier' do |i|
          link_to i.identifier, admin_participant_path(i.id)
        end

        #
        # @good = Datapoint.where(datastream_id: autosense_chest_list).group(:datastream_id, :participant_id).where("sample ->> 0 = '0'").count
        # @bad = Datapoint.where(datastream_id: autosense_chest_list).group(:datastream_id, :participant_id).where("sample ->> 0 != '0'").count
        #
        # logger.ap @good.each
        # logger.ap @bad.each
        #
        # column 'good', ids do |i|
        #   logger.ap i
        #   @good[i]
        # end
        # column :bad

        column 'RIP' do
          ds = Datapoint.last_window((Time.now.utc-1.hours)..(Time.now.utc)).where(datastream_id: autosense_chest_list)

          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'ECG', :id do |i|
          ds = Datapoint.last_window((Time.now.utc-1.hours)..(Time.now.utc)).where(datastream_id: autosense_chest_list)
          good=ds.where("sample ->> 1 = '0'").count
          bad=ds.where("sample ->> 1 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'Wrist (AS)', :id do |i|
          ds = Datapoint.last_window((Time.now.utc-1.hours)..(Time.now.utc)).where(datastream_id: autosense_wrist_list)
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'Wrist (MS)', :id do |i|
          ds = Datapoint.last_window((Time.now.utc-1.hours)..(Time.now.utc)).where(datastream_id: microsoft_band_list)
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'EMA', :id do |i|
          ds = Datapoint.last_window((Time.now.utc-1.hours)..(Time.now.utc)).where(datastream_id: survey_list)
          if ds.count > 0
            ds.count
          end
        end
      end
    end

    panel "Current Day" do
      table_for study.participants do
        column 'Identifier' do |i|
          link_to i.identifier, admin_participant_path(i.id)
        end

        column 'RIP', :id do |i|
          ds = Datapoint.last_window((Time.now.beginning_of_day)..(Time.now.end_of_day)).where(datastream_id: autosense_chest_list)
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'ECG', :id do |i|
          ds = Datapoint.last_window((Time.now.beginning_of_day)..(Time.now.end_of_day)).where(datastream_id: autosense_chest_list)
          good=ds.where("sample ->> 1 = '0'").count
          bad=ds.where("sample ->> 1 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'Wrist (AS)', :id do |i|
          ds = Datapoint.last_window((Time.now.beginning_of_day)..(Time.now.end_of_day)).where(datastream_id: autosense_wrist_list)
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end
        column 'Wrist (MS)', :id do |i|
          ds = Datapoint.last_window((Time.now.beginning_of_day)..(Time.now.end_of_day)).where(datastream_id: microsoft_band_list)
          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'EMA', :id do |i|
          ds = Datapoint.last_window((Time.now.beginning_of_day)..(Time.now.end_of_day)).where(datastream_id: survey_list)
          if ds.count > 0
            ds.count
          end
        end
      end
    end

    panel "All Data" do
      table_for study.participants do
        column 'Identifier' do |i|
          link_to i.identifier, admin_participant_path(i.id)
        end

        column 'RIP', :id do |i|
          ds = Datapoint.where(datastream_id: autosense_chest_list)

          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'ECG', :id do |i|
          ds = Datapoint.where(datastream_id: autosense_chest_list)

          good=ds.where("sample ->> 1 = '0'").count
          bad=ds.where("sample ->> 1 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'Wrist (AS)', :id do |i|
          ds = Datapoint.where(datastream_id: autosense_wrist_list)

          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'Wrist (MS)', :id do |i|
          ds = Datapoint.where(datastream_id: microsoft_band_list)

          good=ds.where("sample ->> 0 = '0'").count
          bad=ds.where("sample ->> 0 != '0'").count
          if (good+bad) > 0
            (good.to_f/(good+bad)).round(3).to_s + ' (' + good.to_s + '/' + (good+bad).to_s + ')'
          end
        end

        column 'EMA', :id do |i|
          ds = Datapoint.where(datastream_id: survey_list)
          if ds.count > 0
            ds.count
          end
        end
      end
    end

    render partial: 'study', object: @study

    active_admin_comments
  end

  sidebar "Participant details", only: :show do
    table_for study.participants do
      column 'ID' do |id|
        link_to id.id, admin_participant_path(id.id)
      end
      column :identifier
    end
  end


end
