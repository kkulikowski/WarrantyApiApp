class Warranty < ApplicationRecord
  # model association
  belongs_to :product

  # validation
  validates_presence_of :name
end
