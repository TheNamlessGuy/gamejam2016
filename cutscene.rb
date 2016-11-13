class Cutscene
  def initialize(scenes)
    @current_scene = 0
    @scenes = scenes

    @delay = 1000
  end

  def update(delta_time)
    event = @scenes[@current_scene].update delta_time
    
    if Gosu::button_down? Gosu::KbX and @delay <= 0
      return :cutscene_end
    end
    
    if event == :scene_end
      if @current_scene < @scenes.length - 1
        @current_scene += 1
      else
        return :cutscene_end
      end
    end

    @delay -= delta_time
  end

  def draw
    @scenes[@current_scene].draw
  end

  def reset
    @current_scene = 0
    @scenes.each do |s|
      s.reset
    end
    @delay = 1000
  end
end
