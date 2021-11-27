require_relative './texto_utiles'
class PantallaAyuda
  include TextoUtiles

  COLOR_AYUDA = Gosu::Color::YELLOW.dup
  COLOR_FONDO = Gosu::Color::BLACK.dup
  COLOR_COMO_JUGAR = Gosu::Color::RED.dup
  COLOR_DIFICULTAD = Gosu::Color::GREEN.dup
  COLOR_NAVES = Gosu::Color::BLUE.dup
  COLOR_INICIO = Gosu::Color::WHITE.dup

  def initialize
    @titulo = Gosu::Font.new(100, {name: 'fonts/Stjldbl1.ttf'})
    @explacion = Gosu::Font.new(40)
  end

  def dibujar
    Gosu.draw_rect(20, 20,
                   Juego::PANTALLA_ANCHO-20,
                   Juego::PANTALLA_ALTO-20, COLOR_FONDO, ZOrder::FONDO_AYUDA)

    texto = "ayuda"
    @titulo.draw_text(texto,
                      centrar_texto(@titulo, texto),
                      5,
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
    agregar_texto("Disparo: Z", 340)                                  
    agregar_texto("Como Jugar:", 400, COLOR_COMO_JUGAR)
    agregar_texto("Objetivo: cada jugador tiene que llegar a los mil puntos", 440, COLOR_COMO_JUGAR)
    agregar_texto("Como ganar puntos: cada jugador tiene que comer estrellas, cada estrella suma 10 puntos", 480, COLOR_COMO_JUGAR)
    agregar_texto("Dificultad:", 560, COLOR_DIFICULTAD)
    agregar_texto("cada nave puede tirar un disparo, si te toca un disparo perdes una vida", 600, COLOR_DIFICULTAD)
    agregar_texto("si chocan cada jugador pierde una vida", 640, COLOR_DIFICULTAD)
    agregar_texto("cada ves que vuelven a jugar las naves cambian", 700, COLOR_NAVES)
    agregar_texto("una nave cambia a diferentes tipos de naves de la resistencia", 740, COLOR_NAVES)
    agregar_texto("y la otra nave cambia a diferentes tipos de naves del imperio", 780, COLOR_NAVES)
    agregar_texto("j: volver a jugar", 840, COLOR_INICIO)
  end

  def manejar_boton(juego, id)
    if boton_salir_ayuda?(id)
      juego.salir_ayuda
    end
  end

  private
  
  def boton_salir_ayuda?(id)
    id == Gosu::KB_J
  end  

  def agregar_texto(texto, posicion_y, color = COLOR_AYUDA)
    @explacion.draw_text(texto,
      centrar_texto(@explacion, texto),
      posicion_y,
      ZOrder::UI, 1.0, 1.0, color)
  end
end