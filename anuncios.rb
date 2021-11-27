require_relative './texto_utiles'

class Anuncios

  include TextoUtiles

  COLOR_GANADOR = Gosu::Color::FUCHSIA.dup
  COLOR_FIN_JUEGO = Gosu::Color::WHITE.dup

  def initialize
    @titulo_ganador = Gosu::Font.new(100)
    @titulo_fin_juego = Gosu::Font.new(100)
    @titulo_recibio_disparo = Gosu::Font.new(100)
    @titulo_continuar = Gosu::Font.new(40)
  end

  def anunciar_ganador(nombre_ganador)
    texto = "Ganaste #{nombre_ganador}!!!"
    @titulo_ganador.draw_text(texto,
                              centrar_texto(@titulo_ganador, texto),
                              Juego::MITAD_PANTALLA_ALTO-50,
                              ZOrder::UI, 1.0, 1.0, COLOR_GANADOR)
    texto = "Tocá R para empezar de nuevo"
    @titulo_continuar.draw_text(texto,
                                centrar_texto(@titulo_continuar, texto),
                                100,
                                ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)
  end

  def anunciar_disparo(nombre_herido)
    texto = "La nave de #{nombre_herido} recibio un disparo"
    @titulo_recibio_disparo.draw_text(texto,
                                      centrar_texto(@titulo_recibio_disparo, texto),
                                      140,
                                      ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)
    texto = "Tocá C para continuar"
    @titulo_continuar.draw_text(texto,
                                centrar_texto(@titulo_continuar, texto),
                                210,
                                ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)

  end

  def anunciar_choque
    texto = "Hubo un choque!!!"
    @titulo_fin_juego.draw_text(texto,
                                centrar_texto(@titulo_fin_juego, texto),
                                140,
                                ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)
    texto = "Tocá C para continuar"
    @titulo_continuar.draw_text(texto,
                                centrar_texto(@titulo_continuar, texto),
                                230,
                                ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)

  end

  def anunciar_fin_juego
    texto = "Se quedaron sin vidas. Tocá R para empezar de nuevo"
    @titulo_continuar.draw_text(texto,
                                centrar_texto(@titulo_continuar, texto),
                                100,
                                ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)
  end

end