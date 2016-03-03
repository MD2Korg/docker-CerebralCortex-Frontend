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


    table_for Datastream.where(participant_id: participant.id) do
      column 'Datasource', :id do |ds|
        Datastream.find_by_id(ds).datasource.display_name
      end

      column 'Data points', :id do |dsid|
        Datapoint.where(datastream_id: dsid).count
      end
      column 'Data points (current day)', :id do |dsid|
        Datapoint.where(datastream_id: dsid, timestamp: (Time.now.at_beginning_of_day)..(Time.now.at_end_of_day)).count
      end
    end

    # sidebar "Datasource", only: :show do
    #   table_for Datastream.where(datasource_id: datasource.id) do
    #     column 'Participants', :participant_id do |pid|
    #       Participant.find_by_id(pid.participant_id).display_name
    #     end
    #   end
    # end
    # column 'Datapoint count' do |ds|
    #   Datapoint.where(datastream_id: Datastream.where(datasource_id: ds.id).collect(&:id)).count
    #
    # end


    active_admin_comments
  end

  sidebar "Study details", only: :show do
    table_for participant.studies do
      column :identifier
      column :name
    end
  end

end
