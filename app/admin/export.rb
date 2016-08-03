ActiveAdmin.register_page 'Export' do
  content do
    render partial: 'export', locals: {id: params['id'], name: params['name'], participant: params['participant']}
  end
end
