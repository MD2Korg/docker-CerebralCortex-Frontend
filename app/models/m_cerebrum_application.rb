class MCerebrumApplication < ActiveRecord::Base
  has_many :datasource

  def display_name
    self.id.to_s + ':' + self.identifier + " (" + self.applicationtype + ")"
  end
end
