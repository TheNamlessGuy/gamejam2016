require "gosu"

#ENTERPRISE QUALITY CODING

def gosu_draw_rect(x1, y1, x2, y2, hexcolor, z)
  color = Gosu::Color.new(hexcolor)
  Gosu::draw_quad(x1, y1, color, x2, y1, color, x2, y2, color, x1, y2, color, z)
end

def gosu_draw_rect_from_hitbox(hitbox, hexcolor, z)
  gosu_draw_rect(hitbox.get[0], hitbox.get[1],
                 hitbox.get[0] + hitbox.get[2],
                 hitbox.get[1] + hitbox.get[3],
                 hexcolor, z)
end
