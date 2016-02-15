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

  permit_params :datastream_id,
                :timestamp,
                :sample

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :datastream_id
      f.input :timestamp
      f.input :sample, as: :text
    end
    f.actions
  end

end
