class MCerebrumPlatformApp < ActiveRecord::Base
  has_many :datasource

  def display_name
    self.id.to_s + ':' + self.identifier + " (" + self.platformapptype + ")"
  end
end
