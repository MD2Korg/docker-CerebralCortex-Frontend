ActiveAdmin.register Datastream do

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

  permit_params :participant_id,
                :datasource_id

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :participant_id
      f.input :datasource_id
    end
    f.actions
  end

end
