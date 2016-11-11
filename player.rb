class Player
  def initialize(x, y)
    @x = x
    @y = y
    @@image = Gosu::Image.new("res/player.png")
  end

  def update
    if Gosu::button_down? Gosu::KbRight then
      # Move right
      puts "Move Right"
    elsif Gosu::button_down? Gosu::KbLeft then
      # Move left
      puts "Move left"
    elsif Gosu::button_down? Gosu::KbDown then
      # Aim down
      puts "Aim down"
    elsif Gosu::button_down? Gosu::KbUp then
      # Aim up
      puts "Aim up"
    elsif Gosu::button_down? Gosu::KbX then
      # Shoot
      puts "Shoot"
    elsif Gosu::button_down? Gosu::KbZ then
      # Jump
      puts "Jump"
    end
  end

  def draw
    @@image.draw(@x, @y, 0)
  end
end
