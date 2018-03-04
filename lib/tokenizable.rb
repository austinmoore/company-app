require 'generate_token'

# @example
#   class MyModel < ActiveRecord::Base
#     include Tokenizable
#     generate_token :identity, delimiter: ':', block_count: 2
#   end
module Tokenizable
  extend ActiveSupport::Concern

  included do
    before_create :initialize_token
  end

  class_methods do
    attr_reader :token_attr_name
    attr_reader :token_options

    # @see GenerateToken#call for valid options
    def generate_token(attr_name, options = {})
      raise ArgumentError, 'attr_name cannot be blank' if attr_name.blank?
      @token_attr_name = attr_name
      @token_options = options
    end
  end

  def initialize_token
    attr_name = self.class.token_attr_name
    options = self.class.token_options
    raise 'Usage: `generate_token :attr_name` must be called!' unless
      attr_name && options
    _initialize_token(GenerateToken.new, attr_name, options)
  end

  def _initialize_token(generator, attr_name, options)
    loop do
      token = generator.call(options.slice(:block_count, :delimiter))
      unless self.class.where(attr_name => token).exists?
        write_attribute(attr_name, token)
        break
      end
    end
  end
end
