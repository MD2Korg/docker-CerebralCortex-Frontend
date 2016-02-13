class Datastream < ActiveRecord::Base
  has_one :datasource
  has_one :participant
  belongs_to :datapoint
end
