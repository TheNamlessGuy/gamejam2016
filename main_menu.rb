class MainMenu
  def initialize(window)
    srand(1337)

    @title = ["Capitalism   Ruined   My", "Vacation!"]
    @alternatives = ["Play", "Quit"]

    @choice = 0
    @delay = 500

    @current_color = 0
    @colors = [Gosu::Color.new(0xff00afdf),#::AQUA,
               Gosu::Color.new(0xffdf0000),#::RED,
               Gosu::Color.new(0xff00df00),#::GREEN,
               Gosu::Color.new(0xff0000df),#::BLUE,
               Gosu::Color.new(0xffdfdf00),#::YELLOW,
               Gosu::Color.new(0xffdf00df)]

    @font = Gosu::Font.new window, "./ARCADECLASSIC.TTF", 50
    @large_font = Gosu::Font.new window, "./ARCADECLASSIC.TTF", 100

    @image = Gosu::Image.new("res/menu_duck.png")
    @back_image = Gosu::Image.new("res/back_beach.png")
  end

  def update(delta_time)
    @delay -= delta_time
    if Gosu::button_down? Gosu::KbUp
      if @delay <= 0
        
        if @choice != 0
          @choice -= 1
        else
          @choice = @alternatives.length - 1
        end
        
        @delay = 180
      end
    elsif Gosu::button_down? Gosu::KbDown
      if @delay <= 0

        if @choice < @alternatives.length - 1
          @choice += 1
        else
          @choice = 0
        end

        @delay = 180
      end
    elsif Gosu::button_down? Gosu::KbReturn and @delay <= 0
      case @choice
      when 0
        return :play
      when 1
        return :quit
      end
    end
  end

  def draw
    @back_image.draw 0, 0, 0

    @font.draw @title.first, 250, 50, 1, 1, 1, Gosu::Color::WHITE
    @large_font.draw @title.last, 275, 100, 1, 1, 1, @colors[@current_color]

    @alternatives.each_with_index do | a, i |
      if @choice == i
        color = Gosu::Color::RED
      else
        color = Gosu::Color::WHITE
      end
      @font.draw a, 50, 50 + i * 50, 0, 1, 1, color
    end

    randx = rand() * 30
    randy = rand() * 30
    @image.draw_rot 650 + randx, 600 + randy, 0, 45, 0.5, 0.5, 10, 10

    if @current_color == @colors.length - 1
      @current_color = 0
    else
      @current_color += 1
    end
  end  

  def reset
    @delay = 500
  end
end
