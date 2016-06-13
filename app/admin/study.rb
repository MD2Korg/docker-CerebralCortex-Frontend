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

    render 'status_summary', {title: 'Summary', study: study}

    datapoint_last_window = Datapoint.last_window((Time.now.utc-1.hours)..(Time.now.utc))
    render 'status_table', {title: '1 Hour Window', study: study, datapoint_last_window: datapoint_last_window}

    datapoint_last_window = Datapoint.last_window((Time.now.beginning_of_day)..(Time.now.end_of_day))
    render 'status_table', {title: 'Current Day', study: study, datapoint_last_window: datapoint_last_window}

    datapoint_last_window = Datapoint.last_window((Time.now.beginning_of_day-1.day)..(Time.now.end_of_day-1.day))
    render 'status_table', {title: 'Previous Day', study: study, datapoint_last_window: datapoint_last_window}

    # datapoint_last_window = Datapoint
    # render 'status_table', {title: 'All Data', study: study, datapoint_last_window: datapoint_last_window}

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
