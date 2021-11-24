class ControlDelJuego
  attr_reader :ganador, :disparo_acertado

  def initialize(nave_jugador_1, nave_jugador_2)
    @nave_jugador_1, @nave_jugador_2 = nave_jugador_1, nave_jugador_2
    @ganador = nil
    @fin_juego = false
    @colision = false
    @disparo_acertado = false
    @pausar_juego = false
  end

  def juego_en_pausa
    (@ganador || @fin_juego || @pausar_juego)
  end

  def resolver_choque_y_disparos
    resolver_choque
    resolver_disparo(@nave_jugador_1, @nave_jugador_2)
    resolver_disparo(@nave_jugador_2, @nave_jugador_1)
  end

  def resolver_ganador
    @ganador =
      if gano_el_jugador(@nave_jugador_1, @nave_jugador_2)
        @nave_jugador_1
      elsif gano_el_jugador(@nave_jugador_2, @nave_jugador_1)
        @nave_jugador_2
      end
  end

  def ganador?
    !!@ganador
  end

  def disparo_acertado?
    !!@disparo_acertado
  end

  def colision?
    @colision
  end

  def fin_juego?
    @fin_juego
  end

  def reiniciar
    if fin_juego? || ganador?
      @nave_jugador_1.volver_empezar
      @nave_jugador_2.volver_empezar
    end
    @ganador = nil
    @fin_juego = false
    @pausar_juego = false
    @colision = false
    @disparo_acertado = false
  end

  def pausar_juego
    @pausar_juego = true
  end

  def continuar_juego
    @pausar_juego = false
  end

  private

  def gano_el_jugador(nave_con_puntos, nave_sin_vidas)
    nave_con_puntos.gano? || nave_sin_vidas.sin_vidas?
  end

  def resolver_disparo(receptor, disparador)
    if receptor.resolver_disparo(disparador)
      @disparo_acertado = receptor
      @fin_juego = alguna_nave_se_quedo_sin_vidas?
      @pausar_juego = true
    end
  end

  def resolver_choque
    if @nave_jugador_1.resolver_choque(@nave_jugador_2)
      @colision = true
      @pausar_juego = true
      @fin_juego = alguna_nave_se_quedo_sin_vidas?
    end
  end

  def alguna_nave_se_quedo_sin_vidas?
    (@nave_jugador_1.sin_vidas? and @nave_jugador_2.sin_vidas?)
  end


end