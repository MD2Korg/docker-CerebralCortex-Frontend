ActiveAdmin.register Participant do

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

  permit_params :identifier

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :identifier
    end
    f.actions
  end


  show do
    attributes_table do
      row :id
      row :identifier
      row :created_at
      row :updated_at
    end


    panel "Datapoint counts" do
      table_for Datastream.where(participant_id: participant.id) do
        column 'Datastream', :id do |ds|
          link_to ds.id, admin_datastream_path(ds)
        end
        column 'Datasource', :id do |ds|
          datas = Datastream.find_by_id(ds)
          link_to datas.datasource.display_name + datas.datasource.m_cerebrum_application.display_name, admin_datasource_path(Datastream.find_by_id(ds).datasource.id)
        end

        column 'Past 1 hour', :id do |dsid|
          Datapoint.datastream(dsid).where(timestamp: (Time.now.utc-1.hours)..(Time.now.utc)).count
        end
        column 'Current Day', :id do |dsid|
          Datapoint.datastream(dsid).where(timestamp: (Time.now.at_beginning_of_day)..(Time.now.at_end_of_day)).count
        end
        column 'Total', :id do |dsid|
          Datapoint.datastream(dsid).count
        end

        column "Details", :id do |i|
          link_to "data", admin_datapoints_path(q: {datastream_id_eq: i})
        end

      end
    end

    render 'participant', {participant: participant}

    active_admin_comments
  end

  sidebar "Study details", only: :show do
    table_for participant.studies do
      column 'Identifier' do |id|
        link_to id.identifier, admin_study_path(id.id)
      end
      column :name
    end
  end

end
