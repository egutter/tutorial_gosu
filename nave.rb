class Nave

  PUNTAJE_MAXIMO = 1000

  attr_reader :puntaje, :nombre, :posicion_y, :posicion_x, :laser, :vidas
  attr_writer :nombre
  
  def initialize(nombre, color, image)
    # @imagen = Gosu::Image.new("media/starfighter.bmp")
    @imagen = image
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
    @laser = SinLaser.new
    @explotada = SinExplosion.new
  end

  def gano?
    @puntaje >= PUNTAJE_MAXIMO
  end

  def resolver_choque(otra_nave)
    if choco_con?(otra_nave)
      self.perder_vida
      otra_nave.perder_vida
      self.explotar
      otra_nave.explotar
    end
  end

  def resolver_disparo(otra_nave)
    if choco_con?(otra_nave.laser)
      self.perder_vida
      self.explotar
      otra_nave.terminar_disparo
      return true
    end
    return false
  end

  def explotar
    @explotada = Explosion.new(self)
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
    @explotada = SinExplosion.new
  end

  def posicion_inicial
    @velocidad_x = 0.0
    @velocidad_y = 0.0
    @angulo = 0.0
    @explotada = SinExplosion.new
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
    @laser = @laser.mover
  end

  def disparar
    @laser = @laser.nuevo_laser(@posicion_x, @posicion_y, @angulo, @color)
  end

  def dibujar
    @imagen.draw_rot(@posicion_x, @posicion_y, ZOrder::NAVE, @angulo, 0.5, 0.5, 1, 1)#, @color)
    @laser.dibujar
    @explotada.dibujar
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

  def terminar_disparo
    @laser = SinLaser.new
  end

  private

  def choco_con?(otro_elemento)
    Gosu.distance(@posicion_x,
                  @posicion_y,
                  otro_elemento.posicion_x,
                  otro_elemento.posicion_y) < 35
  end
end

class Imperio < Nave
  DESTROYER = "destroyer.png"
  T_FIGHTER = "tie-fighter.png"
  NAVES = [DESTROYER, T_FIGHTER]
  def initialize(nombre)
    @ultima_nave = rand(2)
    nave = NAVES[@ultima_nave]
    super(nombre, Gosu::Color::RED.dup, Gosu::Image.new("media/#{nave}"))
  end

  def volver_empezar
    super
    @ultima_nave = (@ultima_nave+1)%2
    nave = NAVES[@ultima_nave]
    @imagen = Gosu::Image.new("media/#{nave}")
  end
end
class Resistencia < Nave
  FALCON = "falcon.gif"
  XWING = "xwing.png"
  NAVES = [FALCON, XWING]

  def initialize(nombre)
    @ultima_nave = rand(2)
    nave = NAVES[@ultima_nave]
    super(nombre, Gosu::Color::BLUE.dup, Gosu::Image.new("media/#{nave}"))
  end

  def volver_empezar
    super
    @ultima_nave = (@ultima_nave+1)%2
    nave = NAVES[@ultima_nave]
    @imagen = Gosu::Image.new("media/#{nave}")
  end
end