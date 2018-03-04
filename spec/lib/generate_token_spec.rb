require 'spec_helper'
require 'generate_token'

RSpec.describe GenerateToken do
  describe '#call' do
    it 'defaults to : as delimiter and 2 block count' do
      expect(subject.call).to match(/\A\w+:\w+\z/)
    end

    it 'accepts delimiter param' do
      expect(subject.call(delimiter: 'x')).to match(/\A\w+x\w+\z/)
    end

    it 'fails if delimiter is blank' do
      expect do
        subject.call(delimiter: '')
      end.to raise_error(ArgumentError, 'delimiter cannot be blank')
    end

    it 'accepts block_count param' do
      expect(subject.call(block_count: 4)).to match(/\A\w+:\w+:\w+:\w+\z/)
      expect(subject.call(block_count: 1)).to match(/\A\w+\z/)
    end

    it 'fails if block_count is less than 1' do
      expect do
        subject.call(block_count: 0)
      end.to raise_error(ArgumentError, 'block_count cannot be < 1')
    end

    it 'generates token with 4 letters per block' do
      expect(subject.call(block_count: 2)).to match(/\A\w{4}:\w{4}\z/)
    end

    it 'generates token only with capital English letters' do
      100.times do
        expect(subject.call(block_count: 1)).to match(/\A[A-Z]+\z/)
      end
    end

    it 'generates token randomly' do
      # Random doesn't necessarily mean unique. However, if the length is
      # significantly large (i.e. block_count) and the number of tokens
      # generated (i.e. count) is resonably small, then in _most_ cases it
      # won't generate duplicates. This test could still randomly fail, but it
      # is unlikely if the randomization algorithm is decent.
      count = 100
      results = count.times.map { subject.call(block_count: 5) }

      with_count = Hash[results.map {|token| [token, results.count(token)] }]
      expect(with_count.detect { |_, count| count > 1 }).to be_nil
    end
  end
end
