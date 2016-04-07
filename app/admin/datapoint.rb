ActiveAdmin.register Datapoint do

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

  require 'json'

  permit_params :datastream_id,
                :timestamp,
                :sample

  preserve_default_filters!
  remove_filter :datastream
  filter :datastream_id, as: :select, collection: -> { Datastream.all }

  actions :all, except: [:update, :destroy, :edit]

  index do
    selectable_column
    id_column
    column :timestamp
    column :datastream_id
    column 'participant' do |i|
      i.datastream.participant.identifier.to_s + ' (' + i.datastream.participant_id.to_s + ')'
    end
    column 'Sample' do |datapoint|
      datapoint['sample'].to_json
    end

    actions
  end

  show do
    attributes_table do
      row :id
      row :timestamp
      row :created_at
      row :updated_at
      row :datastream
      row :sample do |s|
        s['sample'].to_json
      end
      row :offset
    end
  end

# form do |f|
#   f.semantic_errors
#   f.inputs do
#     f.input :datastream_id
#     f.input :timestamp
#     f.input :sample, as: :text
#   end
#   f.actions
# end


end
