class MCerebrumPlatformApp < ActiveRecord::Base
  belongs_to :datasource

  def display_name
    self.id.to_s + ':' + self.identifier + " (" + self.platformapptype + ")"
  end
end
