require 'gosu'
require_relative './tablero'
require_relative './fondo'
require_relative './anuncios'
require_relative './pantalla_ayuda'
require_relative './pantalla_inicio'
require_relative './pantalla_juego'
require_relative './control_del_juego'
require_relative './nave'
require_relative './z_order'
require_relative './estrella'
require_relative './vidas'
require_relative './laser'
require_relative './explosion'
require_relative './texto_utiles'

class Juego < Gosu::Window
  
  PANTALLA_ANCHO = 1920
  PANTALLA_ALTO = 1080
  MITAD_PANTALLA_ANCHO = (PANTALLA_ANCHO / 2)
  MITAD_PANTALLA_ALTO = PANTALLA_ALTO / 2

  TECLAS_JUGADOR_1 = { izquierda: Gosu::KB_LEFT,
                       derecha: Gosu::KB_RIGHT,
                       arriba: Gosu::KB_UP,
                       abajo: Gosu::KB_DOWN,
                       disparar: Gosu::KB_SPACE}

  TECLAS_JUGADOR_2 = { izquierda: Gosu::KB_A,
                       derecha: Gosu::KB_D,
                       arriba: Gosu::KB_W,
                       abajo: Gosu::KB_S,
                       disparar: Gosu::KB_Z}


  def initialize
    super PANTALLA_ANCHO, PANTALLA_ALTO
    self.caption = "Come estrellas del espacio"

    @nave_jugador_1 = Resistencia.new("Jugador 1")
    @nave_jugador_2 = Imperio.new("Jugador 2")
    @fondo = Fondo.new
    @anuncios = Anuncios.new
    @control_de_juego = ControlDelJuego.new(@nave_jugador_1, @nave_jugador_2)
    iniciar_elementos

    @tablero = Tablero.new(@nave_jugador_1, @nave_jugador_2)
    @pantalla_ayuda = PantallaAyuda.new
    @pantalla_inicio = PantallaInicio.new(self)
    @pantalla_juego = PantallaJuego.new(@fondo, @nave_jugador_1, @nave_jugador_2, @tablero, @control_de_juego, @anuncios)
    @pantalla_actual = @pantalla_inicio
  end

  def update
    return if @control_de_juego.juego_en_pausa

    mover_jugador(@nave_jugador_1, TECLAS_JUGADOR_1)
    mover_jugador(@nave_jugador_2, TECLAS_JUGADOR_2)

    @nave_jugador_1.comer_estrellas(@fondo.estrellas)
    @nave_jugador_2.comer_estrellas(@fondo.estrellas)

    @fondo.crear_estrellas

    @control_de_juego.resolver_choque_y_disparos
    @control_de_juego.resolver_ganador
  end

  def draw
    @pantalla_actual.dibujar
  end

  def button_down(id)
    if boton_escape?(id)
      close
    else
      @pantalla_actual.manejar_boton(self, id)
      super
    end
  end

  def empezar_juego(nombre_jugador_1, nombre_jugador_2)
    @nave_jugador_1.nombre = nombre_jugador_1
    @nave_jugador_2.nombre = nombre_jugador_2
    self.text_input = nil
    @pantalla_actual = @pantalla_juego
    @control_de_juego.continuar_juego
  end

  def ayuda
    @pantalla_actual = @pantalla_ayuda
    @control_de_juego.pausar_juego
  end

  def salir_ayuda
    @pantalla_actual = @pantalla_juego
    @control_de_juego.continuar_juego
  end

  def restart
    iniciar_elementos
    @nave_jugador_1.posicion_inicial
    @nave_jugador_2.posicion_inicial
    @control_de_juego.reiniciar
  end

  private

  def iniciar_elementos
    @nave_jugador_1.posicion(MITAD_PANTALLA_ANCHO - 50, MITAD_PANTALLA_ALTO)
    @nave_jugador_2.posicion(MITAD_PANTALLA_ANCHO + 50, MITAD_PANTALLA_ALTO)
    @fondo.reiniciar
  end

  def mover_jugador(nave_jugador, teclas)
    nave_jugador.girar_izquierda if tecla?(teclas[:izquierda])
    nave_jugador.girar_derecha if tecla?(teclas[:derecha])
    nave_jugador.ascelerar if tecla?(teclas[:arriba])
    nave_jugador.retroceder if tecla?(teclas[:abajo])
    nave_jugador.disparar if tecla?(teclas[:disparar])
    nave_jugador.mover
  end

  def boton_escape?(id)
    id == Gosu::KB_ESCAPE
  end

  def tecla?(tecla)
    Gosu.button_down? tecla
  end

end

Juego.new.show