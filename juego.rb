require 'gosu'
require_relative './nave'
require_relative './z_order'
require_relative './estrella'
require_relative './vidas'

class Juego < Gosu::Window
  
  PANTALLA_ANCHO = 1920
  PANTALLA_ALTO = 1080
  MAXIMO_ESTRELLAS = 100
  COLOR_NAVE_1 = Gosu::Color::RED.dup
  COLOR_NAVE_2 = Gosu::Color::BLUE.dup
  COLOR_GANADOR = Gosu::Color::FUCHSIA.dup
  COLOR_FIN_JUEGO = Gosu::Color::WHITE.dup

  TECLAS_JUGADOR_1 = { izquierda: Gosu::KB_LEFT,
                       derecha: Gosu::KB_RIGHT,
                       arriba: Gosu::KB_UP,
                       abajo: Gosu::KB_DOWN}

  TECLAS_JUGADOR_2 = { izquierda: Gosu::KB_A,
                       derecha: Gosu::KB_D,
                       arriba: Gosu::KB_W,
                       abajo: Gosu::KB_S}

  MITAD_PANTALLA_ANCHO = (PANTALLA_ANCHO / 2)
  MITAD_PANTALLA_ALTO = PANTALLA_ALTO / 2

  def initialize
    super PANTALLA_ANCHO, PANTALLA_ALTO
    self.caption = "Come estrellas del espacio"

    @imagen_de_fondo = Gosu::Image.new("media/space.png", :tileable => true)
    @imagen_de_explosion = Gosu::Image.new("media/explosion.png", :tileable => true)
    @nave_jugador_1 = Nave.new("Ivan", COLOR_NAVE_1)
    @nave_jugador_2 = Nave.new("Emilio", COLOR_NAVE_2)

    @animaciones_estrella = Gosu::Image.load_tiles("media/star.png", 25, 25)

    iniciar_elementos

    @titulo = Gosu::Font.new(40)
    @puntaje = Gosu::Font.new(30)
    @titulo_ganador = Gosu::Font.new(100)
    @titulo_fin_juego = Gosu::Font.new(100)
    @titulo_continuar = Gosu::Font.new(40)
    @sonido_explosion = Gosu::Sample.new("media/explosion.mp3")

    @exploto_sonido = false
    @ganador = nil
    @fin_juego = false
    @colision = false
    @pausar_juego = false
  end

  def update
    return if (@ganador || @fin_juego || @pausar_juego)

    mover_jugador(@nave_jugador_1, TECLAS_JUGADOR_1)
    mover_jugador(@nave_jugador_2, TECLAS_JUGADOR_2)

    @nave_jugador_1.comer_estrellas(@estrellas)
    @nave_jugador_2.comer_estrellas(@estrellas)

    if @nave_jugador_1.resolver_choque(@nave_jugador_2)
      @colision = true
      @fin_juego = las_naves_se_quedaron_sin_vidas?
    end

    if rand(100) < 50 and @estrellas.size < MAXIMO_ESTRELLAS
      @estrellas.push(Estrella.new(@animaciones_estrella))
    end

    @ganador = @nave_jugador_1 if @nave_jugador_1.gano?
    @ganador = @nave_jugador_2 if @nave_jugador_2.gano?
  end

  def draw
    @imagen_de_fondo.draw(0, 0, ZOrder::BACKGROUND)
    @nave_jugador_1.dibujar
    @nave_jugador_2.dibujar
    @estrellas.each { |estrella| estrella.dibujar }
    @titulo.draw_text("Puntaje", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    @puntaje.draw_text("#{@nave_jugador_1.nombre}: #{@nave_jugador_1.puntaje}", 10, 50, ZOrder::UI, 1.0, 1.0, COLOR_NAVE_1)
    @puntaje.draw_text("#{@nave_jugador_2.nombre}: #{@nave_jugador_2.puntaje}", 10, 80, ZOrder::UI, 1.0, 1.0, COLOR_NAVE_2)

    if @ganador
      @titulo_ganador.draw_text("Ganaste #{@ganador.nombre}!!!",
                                MITAD_PANTALLA_ANCHO-250,
                                MITAD_PANTALLA_ALTO-50,
                                ZOrder::UI, 1.0, 1.0, COLOR_GANADOR)
      @titulo_continuar.draw_text("Toca R para empezar de nuevo",
                                  MITAD_PANTALLA_ANCHO-300,
                                  100,
                                  ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)
    end
    if @colision
      @pausar_juego = true
      @titulo_fin_juego.draw_text("Hubo un choque+!!!",
                                  MITAD_PANTALLA_ANCHO-250,
                                  10,
                                  ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)
      @imagen_de_explosion.draw(@nave_jugador_1.posicion_x, @nave_jugador_1.posicion_y, ZOrder::UI)
      unless @exploto_sonido
        @sonido_explosion.play
        @exploto_sonido = true
      end
      if @fin_juego
        @titulo_continuar.draw_text("Te quedaste sin vidas. Toca R para empezar de nuevo",
                                    MITAD_PANTALLA_ANCHO-300,
                                    100,
                                    ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)
      else
        @titulo_continuar.draw_text("Les quedan: #{@nave_jugador_1.nombre} #{@nave_jugador_1.cantidad_vidas} vidas. " +
                                      "#{@nave_jugador_2.nombre} #{@nave_jugador_2.cantidad_vidas} vidas. " +
                                      "Toca Space para continuar",
                                    MITAD_PANTALLA_ANCHO-400,
                                    100,
                                    ZOrder::UI, 1.0, 1.0, COLOR_FIN_JUEGO)
      end
    end
  end

  def button_down(id)
    if boton_escape?(id)
      close
    elsif boton_restart?(id)
      restart
    elsif boton_continuar?(id)
      restart
    else
      super
    end
  end

  private

  def las_naves_se_quedaron_sin_vidas?
    (@nave_jugador_1.sin_vidas? and @nave_jugador_2.sin_vidas?)
  end

  def iniciar_elementos
    @nave_jugador_1.posicion(MITAD_PANTALLA_ANCHO - 50, MITAD_PANTALLA_ALTO)
    @nave_jugador_2.posicion(MITAD_PANTALLA_ANCHO + 50, MITAD_PANTALLA_ALTO)
    @estrellas = Array.new
  end

  def mover_jugador(nave_jugador, teclas)
    nave_jugador.girar_izquierda if tecla?(teclas[:izquierda])
    nave_jugador.girar_derecha if tecla?(teclas[:derecha])
    nave_jugador.ascelerar if tecla?(teclas[:arriba])
    nave_jugador.retroceder if tecla?(teclas[:abajo])
    nave_jugador.mover
  end

  def boton_escape?(id)
    id == Gosu::KB_ESCAPE
  end

  def boton_restart?(id)
    id == Gosu::KB_R
  end

  def boton_continuar?(id)
    id == Gosu::KB_SPACE
  end

  def tecla?(tecla)
    Gosu.button_down? tecla
  end

  def restart
    iniciar_elementos
    if @fin_juego || @ganador
      @vidas = Vidas.new
      @nave_jugador_1.volver_empezar
      @nave_jugador_2.volver_empezar
    end
    @nave_jugador_1.posicion_inicial
    @nave_jugador_2.posicion_inicial
    @ganador = nil
    @fin_juego = false
    @pausar_juego = false
    @colision = false
    @exploto_sonido = false
  end
end

Juego.new.show