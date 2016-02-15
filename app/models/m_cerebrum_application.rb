class MCerebrumApplication < ActiveRecord::Base
  belongs_to :datasource

  def display_name
    self.id.to_s + ':' + self.identifier + " (" + self.applicationtype + ")"
  end
end
