class Employee < ApplicationRecord
  belongs_to :company
  validates :first_name, presence: true
  validates :last_name, presence: true
end
