class Cutscene
  def initialize(scenes)
    @current_scene = 0
    @scenes = scenes
  end

  def update(delta_time)
    event = @scenes[@current_scene].update delta_time
    
    if Gosu::button_down? Gosu::KbX
      return :cutscene_end
    end
    
    if event == :scene_end
      if @current_scene < @scenes.length - 1
        @current_scene += 1
      else
        return :cutscene_end
      end
    end
  end

  def draw
    @scenes[@current_scene].draw
  end
end
