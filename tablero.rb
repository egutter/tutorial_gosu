require_relative './texto_utiles'

class Tablero
  include TextoUtiles

  COLOR_JUGADOR_1 = Gosu::Color::RED.dup
  COLOR_JUGADOR_2 = Gosu::Color::BLUE.dup

  def initialize(nave_1, nave_2)
    @nave_jugador_1, @nave_jugador_2 = nave_1, nave_2
    @titulo = Gosu::Font.new(40)
    @puntaje = Gosu::Font.new(30)
    @credito_cobre = Gosu::Image.new("media/credito_cobre.jpg", :tileable => true)
    @credito_hierro = Gosu::Image.new("media/credito_hierro.jpg", :tileable => true)
  end

  def dibujar
    @titulo.draw_text("Puntaje", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    @puntaje.draw_text(puntaje_jugador(@nave_jugador_1), 10, 60, ZOrder::UI, 1.0, 1.0, COLOR_JUGADOR_1)
    @puntaje.draw_text(puntaje_jugador(@nave_jugador_2), 10, 120, ZOrder::UI, 1.0, 1.0, COLOR_JUGADOR_2)
    @nave_jugador_1.vidas.dibujar(posicion_imagenes_x, 40)
    @nave_jugador_2.vidas.dibujar(posicion_imagenes_x, 100)
    @titulo.draw_text("Credito Imperial", 10, 180, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    @puntaje.draw_text(creditos_imperiales_jugador(@nave_jugador_1), 10, 240, ZOrder::UI, 1.0, 1.0, COLOR_JUGADOR_1)
    @puntaje.draw_text(creditos_imperiales_jugador(@nave_jugador_2), 10, 320, ZOrder::UI, 1.0, 1.0, COLOR_JUGADOR_2)
    @credito_cobre.draw(posicion_imagenes_x, 240, ZOrder::UI)
    @credito_hierro.draw(posicion_imagenes_x, 320, ZOrder::UI)
  end

  def mouse_click_adentro_del_credito_jugador_1?(juego)
    mouse_click_adentro_de_objeto(@credito_cobre, posicion_imagenes_x, 240, juego)
  end

  private

  def posicion_imagenes_x
    largo_puntaje + 20
  end

  def largo_puntaje
    [@puntaje.text_width(puntaje_jugador(@nave_jugador_1)), @puntaje.text_width(puntaje_jugador(@nave_jugador_2))].max
  end

  def puntaje_jugador(nave_jugador)
    "#{nave_jugador.nombre}: #{nave_jugador.puntaje}"
  end

  def creditos_imperiales_jugador(nave_jugador)
    "#{nave_jugador.nombre}: #{nave_jugador.creditos_imperiales}"
  end
end