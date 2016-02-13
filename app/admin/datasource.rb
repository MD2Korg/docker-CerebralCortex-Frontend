ActiveAdmin.register Datasource do

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
  permit_params :identifier, :datasourcetype, :datadescriptor, :metadata

  form do |f|
    f.inputs do
      f.input :identifier
      f.input :datasourcetype
      f.input :datadescriptor, as: :text
      f.input :metadata, as: :text
    end
    f.actions
  end

end
