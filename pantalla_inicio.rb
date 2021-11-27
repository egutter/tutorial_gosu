require_relative './texto_utiles'
require_relative './text_field'

class PantallaInicio
  include TextoUtiles

  attr_reader :text_input

  COLOR_FONDO = Gosu::Color::BLACK.dup
  COLOR_INICIO = Gosu::Color::WHITE.dup
  BOTON_START_X = 800
  BOTON_START_Y = 700

  def initialize(juego)
    @titulo = Gosu::Font.new(200, {name: 'fonts/starjedi/Starjhol.ttf'})
    @nombre_jugador = Gosu::Font.new(40)
    @nombre_jugador_1 = TextField.new(juego, @nombre_jugador, 450, 400) 
    @nombre_jugador_2 = TextField.new(juego, @nombre_jugador, 450, 500) 
    juego.text_input = @nombre_jugador_1
    @cursor = Gosu::Image.new("media/cursor.png")
    @juego = juego
    @font = Gosu::Font.new(32, name: "Nimbus Mono L")
	  @text_fields = [@nombre_jugador_1, @nombre_jugador_2]
    @boton_jugar = Gosu::Image.new("media/boton_jugar_2.png")
  end

  def dibujar
    Gosu.draw_rect(20, 20,
                   Juego::PANTALLA_ANCHO-20,
                   Juego::PANTALLA_ALTO-20, COLOR_FONDO, ZOrder::FONDO_AYUDA)

    texto = "star battle"
    @titulo.draw_text(texto,
                      centrar_texto(@titulo, texto),
                      100,
                      ZOrder::UI, 1.0, 1.0, COLOR_INICIO)
    
    @nombre_jugador.draw_text("Nombre Jugador 1",
                              100,
                              400,
                              ZOrder::UI, 1.0, 1.0, COLOR_INICIO)
    @nombre_jugador.draw_text("Nombre Jugador 2",
                              100,
                              500,
                              ZOrder::UI, 1.0, 1.0, COLOR_INICIO)                         
    @nombre_jugador_1.draw     
    @nombre_jugador_2.draw  
    @cursor.draw(@juego.mouse_x, @juego.mouse_y, 0)         
    
    @boton_jugar.draw(BOTON_START_X, BOTON_START_Y, ZOrder::UI)
  end

  def manejar_boton(juego, id)
    if id == Gosu::KbTab
        
      # Tab key will not be 'eaten' by text fields; use for switching through
      # text fields.
      index = @text_fields.index(juego.text_input) || -1
      nuevo_index = (index + 1) % @text_fields.size
      juego.text_input = @text_fields[nuevo_index]
    elsif id == Gosu::MsLeft
      # Mouse click: Select text field based on mouse position.
      if mouse_click_adentro_del_boton?()
        @juego.empezar_juego(@nombre_jugador_1.text, @nombre_jugador_2.text)
      end
    end
  end

  def mouse_click_adentro_del_boton?()
    boton_fin_x = BOTON_START_X + @boton_jugar.width
    boton_fin_y = BOTON_START_Y + @boton_jugar.height
    
    mouse_dentro_boton_x = (@juego.mouse_x >= BOTON_START_X && @juego.mouse_x <= boton_fin_x)
    mouse_dentro_boton_y = (@juego.mouse_y >= BOTON_START_Y && @juego.mouse_y <= boton_fin_y)

    return mouse_dentro_boton_x && mouse_dentro_boton_y

  end
end