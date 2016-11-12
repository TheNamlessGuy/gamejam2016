class Scene
  def initialize(image, font, captions)
    @image = image

    @current_caption = 0
    @captions = captions
    @font = font

    @delay = 500
  end

  def update(delta_time)
    if Gosu::button_down? Gosu::KbReturn and @delay <= 0
      if @current_caption < @captions.length - 1
        @current_caption += 1
      else
        return :scene_end
      end

      @delay = 500
    else
      @delay -= delta_time
    end
  end

  def draw
    @image.draw 0, 0, 0 if @image

    @font.draw @captions[@current_caption], 50, 500, 1, 1, 1, Gosu::Color::WHITE
  end
end
