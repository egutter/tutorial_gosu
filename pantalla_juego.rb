class PantallaJuego

  CANCIONES = ["imperial-march.mp3", "star-wars.mp3"]

  def initialize(fondo, nave_jugador_1, nave_jugador_2, tablero, control_de_juego, anuncios)
    @fondo, @nave_jugador_1, @nave_jugador_2, @tablero, @control_de_juego, @anuncios = fondo, nave_jugador_1, nave_jugador_2, tablero, control_de_juego, anuncios
    @banda_sonido = Gosu::Song.new("media/#{elegir_cancion}")
  end

  def actualizar
    return if @control_de_juego.juego_en_pausa

    @nave_jugador_1.mover_jugador(Juego::TECLAS_JUGADOR_1)
    @nave_jugador_2.mover_jugador(Juego::TECLAS_JUGADOR_2)

    @nave_jugador_1.comer_estrellas(@fondo.estrellas)
    @nave_jugador_2.comer_estrellas(@fondo.estrellas)

    @fondo.crear_estrellas

    @control_de_juego.resolver_choque_y_disparos(@fondo.meteoritos)
    @control_de_juego.resolver_ganador
  end

  def dibujar
    unless @banda_sonido.playing?
      @banda_sonido.play(true)
    end
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

  def manejar_boton(juego, id)
    if boton_restart?(id)
      juego.restart
      @banda_sonido.stop
      @banda_sonido = Gosu::Song.new("media/#{elegir_cancion}")
    elsif boton_continuar?(id)
      juego.restart
    elsif boton_ayuda?(id)
      juego.ayuda
    elsif id == Gosu::MsLeft
      # Mouse click: Select text field based on mouse position.
      if @tablero.mouse_click_adentro_del_credito_jugador_1?(juego)
        juego.mercado(@nave_jugador_1)
      end
    end
  end

  private

  def elegir_cancion
    @cancion_actual ||= rand(CANCIONES.size)
    @cancion_actual += 1
    CANCIONES[@cancion_actual % CANCIONES.size]
  end

  def boton_restart?(id)
    id == Gosu::KB_R
  end

  def boton_continuar?(id)
    id == Gosu::KB_C
  end

  def boton_ayuda?(id)
    id == Gosu::KB_H
  end

end