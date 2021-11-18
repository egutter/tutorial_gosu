class Nave

  PUNTAJE_MAXIMO = 100

  attr_reader :puntaje, :nombre, :posicion_y, :posicion_x

  def initialize(nombre, color)
    @imagen = Gosu::Image.new("media/starfighter.bmp")
    @sonido = Gosu::Sample.new("media/beep.wav")
    @posicion_x = 0.0
    @posicion_Y = 0.0
    @velocidad_x = 0.0
    @velocidad_y = 0.0
    @angulo = 0.0
    @puntaje = 0
    @color = color
    @nombre = nombre
    @vidas = Vidas.new
  end

  def gano?
    @puntaje >= PUNTAJE_MAXIMO
  end

  def resolver_choque(otra_nave)
    if choco_con?(otra_nave)
      self.perder_vida
      otra_nave.perder_vida
    end
  end

  def sin_vidas?
    @vidas.vacio?
  end

  def perder_vida
    @vidas.perder_vida
  end

  def volver_empezar
    @puntaje = 0
    @vidas.reiniciar
  end

  def posicion_inicial
    @velocidad_x = 0.0
    @velocidad_y = 0.0
    @angulo = 0.0
  end

  def posicion(x, y)
    @posicion_x, @posicion_y = x, y
  end

  def girar_izquierda
    @angulo -= 4.5
  end

  def girar_derecha
    @angulo += 4.5
  end

  def ascelerar
    @velocidad_x += Gosu.offset_x(@angulo, 0.5)
    @velocidad_y += Gosu.offset_y(@angulo, 0.5)
  end

  def retroceder
    @velocidad_x -= Gosu.offset_x(@angulo, 0.5)
    @velocidad_y -= Gosu.offset_y(@angulo, 0.5)
  end

  def mover
    @posicion_x += @velocidad_x
    @posicion_y += @velocidad_y
    @posicion_x %= Juego::PANTALLA_ANCHO
    @posicion_y %= Juego::PANTALLA_ALTO

    @velocidad_x *= 0.95
    @velocidad_y *= 0.95
  end

  def dibujar
    @imagen.draw_rot(@posicion_x, @posicion_y, ZOrder::NAVE, @angulo, 0.5, 0.5, 1, 1, @color)
    @vidas.dibujar
  end

  def comer_estrellas(estrellas)
    estrellas.reject! do |estrella|
      if choco_con?(estrella)
        @puntaje += 10
        @sonido.play
        true
      else
        false
      end
    end
  end

  def cantidad_vidas
    @vidas.cantidad
  end

  private

  def choco_con?(otro_elemento)
    Gosu.distance(@posicion_x,
                  @posicion_y,
                  otro_elemento.posicion_x,
                  otro_elemento.posicion_y) < 35
  end
end