class PantallaJuego

  def initialize(fondo, nave_jugador_1, nave_jugador_2, tablero, control_de_juego, anuncios)
    @fondo, @nave_jugador_1, @nave_jugador_2, @tablero, @control_de_juego, @anuncios = fondo, nave_jugador_1, nave_jugador_2, tablero, control_de_juego, anuncios
  end  
  
  def dibujar
    @fondo.dibujar
    @nave_jugador_1.dibujar
    @nave_jugador_2.dibujar
    @tablero.dibujar

    if @control_de_juego.ganador?
      @anuncios.anunciar_ganador(@control_de_juego.ganador.nombre)
    end

    if @control_de_juego.disparo_acertado?
      @anuncios.anunciar_disparo(@control_de_juego.disparo_acertado.nombre)
    end

    if @control_de_juego.colision?
      @anuncios.anunciar_choque
    end

    if @control_de_juego.fin_juego?
      @anuncios.anunciar_fin_juego
    end
  end
end