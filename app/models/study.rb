class Study < ActiveRecord::Base
  has_and_belongs_to_many :participants

  def display_name
    self.id.to_s + ':' + self.identifier
  end
end
