require 'gosu'
require_relative './tablero'
require_relative './fondo'
require_relative './anuncios'
require_relative './pantalla_ayuda'
require_relative './pantalla_inicio'
require_relative './pantalla_juego'
require_relative './pantalla_nivel_dos'
require_relative './pantalla_mercado'
require_relative './control_del_juego'
require_relative './nave'
require_relative './nave_controlada_por_computadora'
require_relative './z_order'
require_relative './estrella'
require_relative './meteorito'
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

    @fondo = Fondo.new
    @pantalla_inicio = PantallaInicio.new(self)
    @panalla_nivel_dos = PantallaNivelDos.new
    @pantalla_actual = @pantalla_inicio
    @pantalla_ayuda = PantallaAyuda.new
    # @pantalla_actual = @panalla_nivel_dos
  end

  def update
    @pantalla_actual.actualizar
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

  def empezar_juego_un_jugador_vs_computadora(nombre_jugador_1)
    @nave_jugador_1 = Resistencia.new(nombre_jugador_1)
    @nave_jugador_2 = NaveControladaPorComputadora.new
    empezar_juego
  end

  def empezar_juego_dos_jugadores(nombre_jugador_1, nombre_jugador_2)
    @nave_jugador_1 = Resistencia.new(nombre_jugador_1)
    @nave_jugador_2 = Imperio.new(nombre_jugador_2)
    empezar_juego
  end

  def empezar_juego
    @anuncios = Anuncios.new
    @control_de_juego = ControlDelJuego.new(@nave_jugador_1, @nave_jugador_2)
    iniciar_elementos

    @tablero = Tablero.new(@nave_jugador_1, @nave_jugador_2)
    @pantalla_juego = PantallaJuego.new(@fondo, @nave_jugador_1, @nave_jugador_2, @tablero, @control_de_juego, @anuncios)


    self.text_input = nil
    @pantalla_actual = @pantalla_juego
    @control_de_juego.continuar_juego
  end

  def ayuda
    @pantalla_actual = @pantalla_ayuda
    @control_de_juego.pausar_juego
  end

  def mercado(nave_jugador)
    @pantalla_actual = PantallaMercado.new(self, nave_jugador)
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

  def activar_meteoritos(cantidad)
    @fondo.activar_meteoritos(cantidad)
  end

  private

  def iniciar_elementos
    @nave_jugador_1.posicion(MITAD_PANTALLA_ANCHO - 50, MITAD_PANTALLA_ALTO)
    @nave_jugador_2.posicion(MITAD_PANTALLA_ANCHO + 50, MITAD_PANTALLA_ALTO)
    @fondo.reiniciar
  end

  def boton_escape?(id)
    id == Gosu::KB_ESCAPE
  end

end

Juego.new.show