class MainMenu
  def initialize(window)
    @title = ["Capitalism   Ruined   My", "Vacation!"]
    @alternatives = ["Play", "Quit"]

    @choice = 0
    @delay = 0

    @current_color = 0
    @colors = [Gosu::Color::AQUA,
               Gosu::Color::RED,
               Gosu::Color::GREEN,
               Gosu::Color::BLUE,
               Gosu::Color::YELLOW,
               Gosu::Color::FUCHSIA,
               Gosu::Color::CYAN]

    @font = Gosu::Font.new window, "./ARCADECLASSIC.TTF", 50
    @large_font = Gosu::Font.new window, "./ARCADECLASSIC.TTF", 100

    @image = Gosu::Image.new("res/menu_duck.png")
  end

  def update(delta_time)
    if Gosu::button_down? Gosu::KbUp
      if @delay <= 0

        if @choice != 0
          @choice -= 1
        else
          @choice = @alternatives.length - 1
        end
        
        @delay = 180
      else
        @delay -= delta_time
      end
    elsif Gosu::button_down? Gosu::KbDown
      if @delay <= 0

        if @choice < @alternatives.length - 1
          @choice += 1
        else
          @choice = 0
        end

        @delay = 180
      else
        @delay -= delta_time
      end
    elsif Gosu::button_down? Gosu::KbReturn
      case @choice
      when 0
        return :play
      when 1
        return :quit
      end
    else
      @delay = 0
    end
  end

  def draw
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

    @image.draw_rot 650, 600, 0, 45, 0.5, 0.5, 10, 10

    if @current_color == @colors.length - 1
      @current_color = 0
    else
      @current_color += 1
    end
  end  
end
