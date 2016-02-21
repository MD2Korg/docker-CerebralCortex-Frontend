class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :m_cerebrum_applications, :apptype, :applicationtype
  end
end