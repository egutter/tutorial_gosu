class Explosion
  def initialize(nave_jugador)
    @nave_jugador = nave_jugador
    @imagen_de_explosion = Gosu::Image.new("media/explosion.png", :tileable => true)
    @sonido_explosion = Gosu::Sample.new("media/explosion.mp3")
    @exploto_sonido = false
  end

  def dibujar
    @imagen_de_explosion.draw(@nave_jugador.posicion_x-20, @nave_jugador.posicion_y-20, ZOrder::UI)
    unless @exploto_sonido
      @sonido_explosion.play
      @exploto_sonido = true
    end
  end
end

class SinExplosion
  def dibujar
  end
end