require_relative './texto_utiles'
class PantallaAyuda
  include TextoUtiles

  COLOR_AYUDA = Gosu::Color::WHITE.dup

  def initialize
    @titulo = Gosu::Font.new(100)
    @explacion = Gosu::Font.new(40)
  end

  def dibujar
    Gosu.draw_rect(20, 20,
                   Juego::PANTALLA_ANCHO-20,
                   Juego::PANTALLA_ALTO-20, c, ZOrder::FONDO_AYUDA)

    texto = "AYUDA"
    @titulo.draw_text(texto,
                      centrar_texto(@titulo_ganador, texto),
                      20,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)
  end
end