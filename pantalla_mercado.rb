require_relative './texto_utiles'
class PantallaMercado
  include TextoUtiles

  COLOR_AYUDA = Gosu::Color::BLACK.dup
  COLOR_FONDO = Gosu::Color::WHITE.dup
  COLOR_COMO_JUGAR = Gosu::Color::RED.dup
  COLOR_DIFICULTAD = Gosu::Color::GREEN.dup
  COLOR_NAVES = Gosu::Color::BLUE.dup
  COLOR_INICIO = Gosu::Color::WHITE.dup

  def initialize(juego, nave_jugador)
    @juego = juego
    @titulo = Gosu::Font.new(100, {name: 'fonts/Stjldbl1.ttf'})
    @explacion = Gosu::Font.new(40)
    @meteorito = Gosu::Image.new("media/meteorito.jpeg", :tileable => true)
    @nave_jugador = nave_jugador
    @mercancias = [
      {imagen: @meteorito, x: 300, y: 240, 
        accion: method(:comprar_meteorito) }]
  end

  def actualizar

  end

  def dibujar
    Gosu.draw_rect(20, 20,
                   Juego::PANTALLA_ANCHO-20,
                   Juego::PANTALLA_ALTO-20, COLOR_FONDO, ZOrder::FONDO_AYUDA)

    texto = "mercado"
    @titulo.draw_text(texto,
                      centrar_texto(@titulo, texto),
                      5,
                      ZOrder::UI, 1.0, 1.0, COLOR_AYUDA)

    @meteorito.draw(300, 240, ZOrder::UI)  
    agregar_texto("Meteorito", 340, 240+@meteorito.height)
    agregar_texto("10 creditos", 340, 280+@meteorito.height)                  
  end

  def manejar_boton(juego, id)
    if boton_salir_ayuda?(id)
      juego.salir_ayuda
    elsif id == Gosu::MsLeft
      # Mouse click: Select text field based on mouse position.
      if mercancia = mouse_click_sobre_mercancia?
        mercancia[:accion].call
        juego.salir_ayuda
      end
    end
  end

  def comprar_meteorito
    @nave_jugador.restar_credito(10)
    @juego.activar_meteoritos(5)
  end

  private
  
  def mouse_click_sobre_mercancia?()
    @mercancias.find do |mercancia| 
      mouse_click_adentro_de_objeto(mercancia[:imagen], mercancia[:x], mercancia[:y], @juego)
    end
  end

  def boton_salir_ayuda?(id)
    id == Gosu::KB_J
  end  

  def agregar_texto(texto, posicion_x, posicion_y, color = COLOR_AYUDA)
    @explacion.draw_text(texto,
      posicion_x,
      posicion_y,
      ZOrder::UI, 1.0, 1.0, color)
  end
end