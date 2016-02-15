class Datapoint < ActiveRecord::Base
  has_one :datastream
end
