class Fondo
  MAXIMO_ESTRELLAS = 100

  attr_reader :estrellas

  def initialize
    @imagen_de_fondo = Gosu::Image.new("media/space.png", :tileable => true)
    @imagen_meteorito = Gosu::Image.new("media/meteorito.jpeg", :tileable => true)
    @animaciones_estrella = Gosu::Image.load_tiles("media/star.png", 25, 25)
    @estrellas = Array.new
    @meteoritos = Array.new
  end

  def crear_estrellas
    if rand(100) < 50 and @estrellas.size < MAXIMO_ESTRELLAS
      @estrellas.push(Estrella.new(@animaciones_estrella))
    end
  end

  def dibujar
    @imagen_de_fondo.draw(0, 0, ZOrder::BACKGROUND)
    @estrellas.each { |estrella| estrella.dibujar }
    @meteoritos.each { |meteorito| meteorito.dibujar }
  end

  def reiniciar
    @estrellas = Array.new
    @meteoritos = Array.new
  end

  def activar_meteoritos(cantidad)
    (1..cantidad).each do
      @meteoritos.push(Meteorito.new(@imagen_meteorito))
    end
  end
end