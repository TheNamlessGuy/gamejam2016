class Inventory
  attr_accessor :money, :health, :lives, :bulletcount

  def initialize(window)
    @money = 0
    @bulletcount = 20

    @font = Gosu::Font.new(window, './ARCADECLASSIC.TTF', 50)

    @succ = Gosu::Image.new('res/bullet.png')
  end

  def draw
    @font.draw('CASH   ' + @money.to_s, 10, 10, 1, 1, 1, Gosu::Color::WHITE)
    @succ.draw(10, 555, 1)
    @font.draw('  x  ' + @bulletcount.to_s, 60, 550, 1, 1, 1, Gosu::Color::WHITE)
  end
end
