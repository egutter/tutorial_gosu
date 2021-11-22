class Tablero

  COLOR_JUGADOR_1 = Gosu::Color::RED.dup
  COLOR_JUGADOR_2 = Gosu::Color::BLUE.dup

  def initialize(nave_1, nave_2)
    @nave_jugador_1, @nave_jugador_2 = nave_1, nave_2
    @titulo = Gosu::Font.new(40)
    @puntaje = Gosu::Font.new(30)
  end

  def dibujar
    @titulo.draw_text("Puntaje", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    @puntaje.draw_text(puntaje_jugador(@nave_jugador_1), 10, 60, ZOrder::UI, 1.0, 1.0, COLOR_JUGADOR_1)
    @puntaje.draw_text(puntaje_jugador(@nave_jugador_2), 10, 120, ZOrder::UI, 1.0, 1.0, COLOR_JUGADOR_2)
    posicion_vidas_x = largo_puntaje + 20
    @nave_jugador_1.vidas.dibujar(posicion_vidas_x, 40)
    @nave_jugador_2.vidas.dibujar(posicion_vidas_x, 100)
  end

  private

  def largo_puntaje
    [@puntaje.text_width(puntaje_jugador(@nave_jugador_1)), @puntaje.text_width(puntaje_jugador(@nave_jugador_2))].max
  end

  def puntaje_jugador(nave_jugador)
    "#{nave_jugador.nombre}: #{nave_jugador.puntaje}"
  end
end