require_relative './z_order'

class Meteorito
  attr_reader :posicion_x, :posicion_y

  def initialize(imagen)
    @imagen = imagen
    @posicion_x = rand * Juego::PANTALLA_ANCHO
    @posicion_y = rand * Juego::PANTALLA_ALTO
  end

  def dibujar
    @imagen.draw(@posicion_x - @imagen.width / 2.0, @posicion_y - @imagen.height / 2.0,
             ZOrder::STARS, 1, 1)
  end
end