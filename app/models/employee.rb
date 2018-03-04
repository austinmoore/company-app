require 'tokenizable'

class Employee < ApplicationRecord
  include Tokenizable
  generate_token :identifier, delimiter: '-', block_count: 3

  belongs_to :company
  validates :first_name, presence: true
  validates :last_name, presence: true
end
