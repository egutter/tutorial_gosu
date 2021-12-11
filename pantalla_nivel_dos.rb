class PantallaNivelDos
  include TextoUtiles

  attr_reader :text_input

  TECLAS_JUGADOR_1 = { izquierda: Gosu::KB_LEFT,
                       derecha: Gosu::KB_RIGHT,
                       arriba: Gosu::KB_UP,
                       abajo: Gosu::KB_DOWN,
                       disparar: Gosu::KB_SPACE}

  COLOR_FONDO = Gosu::Color::WHITE.dup
  COLOR_INICIO = Gosu::Color::WHITE.dup
  BOTON_START_X = 800
  BOTON_START_Y = 700

  def initialize
    @luke_parado = Gosu::Image.new("media/luke-parado.png")
    @luke_correr = Gosu::Image.load_tiles("media/luke-correr.png", 50, 64)
    @luke = @luke_parado
  end

  def actualizar
    if tecla?(TECLAS_JUGADOR_1[:derecha])
      raise "tecla right"
      @luke = @luke_correr[Gosu.milliseconds / 100 % @luke_correr.size]
    end
  end

  def dibujar
    Gosu.draw_rect(20, 20,
                   Juego::PANTALLA_ANCHO-20,
                   Juego::PANTALLA_ALTO-20, COLOR_FONDO, ZOrder::BACKGROUND)
    @luke.draw(100, 100, ZOrder::NAVE)
    index = 0
    @luke_correr.each do |lukito|
      index += 100
      lukito.draw(100+index, 200, ZOrder::NAVE)
    end
  end

  def tecla?(tecla)
    Gosu.button_down? tecla
  end

end