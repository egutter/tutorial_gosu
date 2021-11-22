class Laser

  attr_reader :posicion_y, :posicion_x

  def initialize(pos_x, pos_y, angulo, color)
    @imagen = Gosu::Image.new("media/laser_#{elegir_color(color)}.png")
    offset_y = Gosu.offset_y(angulo, 40)
    offset_x = Gosu.offset_x(angulo, 40)
    @posicion_x, @posicion_y,  = pos_x + offset_x, pos_y + offset_y
    # 0 => -1 -40
    # 90 => 40

    @angulo = angulo
    @last_move = 0
    @velocidad_x = 0
    @velocidad_y = 0
  end

  def mover
    new_move = Gosu.milliseconds / 10
    fuera_pantalla = false
    if @last_move != new_move
      @velocidad_x += Gosu.offset_x(@angulo, 0.5)
      @velocidad_y += Gosu.offset_y(@angulo, 0.5)
      @posicion_x += @velocidad_x
      @posicion_y += @velocidad_y
      @last_move = new_move
      if @posicion_x > Juego::PANTALLA_ANCHO || @posicion_y > Juego::PANTALLA_ALTO
        fuera_pantalla = true
      end
      if @posicion_x < 0 || @posicion_y < 0
        fuera_pantalla = true
      end
    end
    return !fuera_pantalla ? self : SinLaser.new
  end

  def dibujar
    @imagen.draw_rot(@posicion_x, @posicion_y, ZOrder::UI, @angulo-90, 0.5, 0.5, 1, 1)
  end

  def nuevo_laser(posicion_x, posicion_y, angulo, color)
    self
  end

  private

  def elegir_color(color)
    Gosu::Color::RED == color ? 'rojo' : 'azul'
  end
end

class SinLaser
  def initialize
    @sonido = @sonido = Gosu::Sample.new("media/disparo_laser.wav")
  end

  def dibujar
  end
  def mover
    self
  end
  def nuevo_laser(posicion_x, posicion_y, angulo, color)
    @sonido.play
    Laser.new(posicion_x, posicion_y, angulo, color)
  end
  def posicion_x
    Float::INFINITY
  end
  def posicion_y
    Float::INFINITY
  end
end