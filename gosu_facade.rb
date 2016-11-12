require "gosu"

#ENTERPRISE QUALITY CODING

def gosu_draw_rect(x1, y1, x2, y2, hexcolor, z)
  color = Gosu::Color.new(hexcolor)
  Gosu::draw_quad(x1, y1, color, x2, y1, color, x2, y2, color, x1, y2, color, z)
end
