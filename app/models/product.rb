class Product < ApplicationRecord
  # model association
  has_many :warranties, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
