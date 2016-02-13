class Participant < ActiveRecord::Base
  belongs_to :datastream
  has_and_belongs_to_many :studies
end
