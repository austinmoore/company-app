require 'tokenizable'

class Company < ApplicationRecord
  include Tokenizable
  generate_token :identity, delimiter: ':', block_count: 2

  has_many :employees, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
