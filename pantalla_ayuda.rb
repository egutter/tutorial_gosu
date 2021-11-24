require_relative './texto_utiles'
class PantallaAyuda
  include TextoUtiles

  COLOR_AYUDA = Gosu::Color::WHITE.dup
  COLOR_FONDO = Gosu::Color::BLACK.dup

  def initialize
    @titulo = Gosu::Font.new(100)
    @explacion = Gosu::Font.new(40)
  end

  def dibujar
    Gosu.draw_rect(20, 20,
                   Juego::PANTALLA_ANCHO-20,
                   Juego::PANTALLA_ALTO-20, COLOR_FONDO, ZOrder::FONDO_AYUDA)

    texto = "AYUDA"
    @titulo.draw_text(texto,
                      centrar_texto(@titulo, texto),
                      20,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)

    texto = "Teclas Jugador 1" 
    @explacion.draw_text(texto,
                      centrar_texto(@explacion, texto),
                      120,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)
    texto = "Movimientos: Cursor Arriba, Cursor Abajo, Cursor Izquierda, Cursor Derecha" 
    @explacion.draw_text(texto,
                      centrar_texto(@explacion, texto),
                      160,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)                  
    texto = "Disparo: Espacio" 
    @explacion.draw_text(texto,
                      centrar_texto(@explacion, texto),
                      200,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)          
    texto = "Teclas Jugador 2" 
    @explacion.draw_text(texto,
                      centrar_texto(@explacion, texto),
                      260,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)
    texto = "Movimientos: W (arriba), S (abajo), A (izquierda), D (derecha)" 
    @explacion.draw_text(texto,
                      centrar_texto(@explacion, texto),
                      300,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)                  
    texto = "Disparo: Z" 
    @explacion.draw_text(texto,
                      centrar_texto(@explacion, texto),
                      340,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)                                            
                  
  end
end