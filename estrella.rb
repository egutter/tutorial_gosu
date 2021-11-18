require_relative './z_order'

class Estrella
  attr_reader :posicion_x, :posicion_y

  def initialize(animaciones)
    @animaciones = animaciones
    @color = Gosu::Color::BLACK.dup
    @color.red = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue = rand(256 - 40) + 40
    @posicion_x = rand * Juego::PANTALLA_ANCHO
    @posicion_y = rand * Juego::PANTALLA_ALTO
  end

  def dibujar
    imagen = @animaciones[Gosu.milliseconds / 100 % @animaciones.size]
    imagen.draw(@posicion_x - imagen.width / 2.0, @posicion_y - imagen.height / 2.0,
             ZOrder::STARS, 1, 1, @color, :add)
  end
end