ActiveAdmin.register MCerebrumPlatform do

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
  belongs_to :datasource
  navigation_menu :datasource


  permit_params :identifier, :platformtype, :metadata

  form do |f|
    f.inputs do
      f.input :identifier
      f.input :platformtype
      f.input :metadata, as: :text
    end
    f.actions
  end


end
