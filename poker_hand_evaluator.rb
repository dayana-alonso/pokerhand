# Evaluates poker hands for validity and determines the winning hand
class PokerHandEvaluator
  class InvalidHandError < Exception; end

  attr_reader :hands

  MAX_CARD = 5
  MIN_HAND = 1

  def initialize(hands)
    @hands = hands.map(&:split)

    invalid_hand_error_check
  end

  def hand_classifications
    results = []

    hands.each do |hand|
      cards.each do |categroy, card_hand|
        results << categroy.to_s if (card_hand & hand == card_hand)
      end
    end

    return results
  end

  private

  def cards
    {
      HIGH_CARD: %w[AS KC 3H 8C 5H],
      ONE_PAIR: %w[7H 7S 4H 8D 5D],
      TWO_PAIR: %w[8H 8S 4S 7D 7C],
      THREE_OF_A_KIND: %w[0C 0S 0D KS QC],
      STRAIGHT: %w[5S 4D 3S 2H AC],
      FLUSH: %w[QD KD AD 3D 2D],
      FULL_HOUSE: %w[JC JS JD 6D 6H],
      FOUR_OF_A_KIND: %w[9H 9S 9D 9C 2S],
      STRAIGHT_FLUSH: %w[6C 5C 4C 3C 2C],
      ROYAL_FLUSH: %w[AH KH QH JH 0H],
    }
  end


  def invalid_hand_error_check
    hands.each do |h|
      # hand contains same card
      raise_error if h.uniq.length != h.length
      # hand contains less than or more than 5 cards
      raise_error if h.count != MAX_CARD
    end
    # different hands contain the same card
    return unless hands.count > MIN_HAND
    # TODO: refactor to be simpler
    filter = []
    hands.each do |list|
      list.each do |l|
        raise_error if filter.include?(l)
        filter << l
      end
    end
  end

  def raise_error
    raise InvalidHandError.new
  end
end
