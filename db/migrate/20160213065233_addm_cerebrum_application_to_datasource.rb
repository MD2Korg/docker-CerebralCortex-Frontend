class AddmCerebrumApplicationToDatasource < ActiveRecord::Migration
  def change
    add_reference :datasources, :m_cerebrum_application, index: true, foreign_key: true
  end
end
