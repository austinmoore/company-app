# Random token generator
class GenerateToken
  BLOCK_LENGTH = 4
  private_constant :BLOCK_LENGTH
  VALID_CHARS = ('A'..'Z').to_a.freeze

  # @param block_count [Integer] number of blocks of characters the token
  #   should be comprised of (default: 2)
  # @param delimiter [String] character(s) between each block (default: ':')
  # @return [String] randomly generated string composed of only upper case
  #   English letters and the delimiter
  def call(delimiter: ':', block_count: 2)
    raise ArgumentError, 'delimiter cannot be blank' if delimiter.blank?
    block_count = block_count.to_i
    raise ArgumentError, 'block_count cannot be < 1' if block_count < 1

    block_count.times
      .map { VALID_CHARS.sample(BLOCK_LENGTH).join('') }
      .join(delimiter)
  end
end
