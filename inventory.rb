class Inventory
  attr_accessor :money, :health, :lives, :bulletcount

  def initialize
    @money = 0
    @health = 100
    @lives = 3
    @bulletcount = 20
  end
end
