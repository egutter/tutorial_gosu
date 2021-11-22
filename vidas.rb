class Vidas
  def initialize
    reiniciar
  end

  def dibujar(posicion_x, posicion_y)
    @imagenes_de_corazon.each_with_index do |corazon, index|
      corazon.draw(posicion_x + (index*50), posicion_y, ZOrder::UI)
    end
  end

  def perder_vida
    @imagenes_de_corazon.pop
  end

  def cantidad
    @imagenes_de_corazon.size
  end

  def vacio?
    @imagenes_de_corazon.empty?
  end

  def reiniciar
    @imagenes_de_corazon = (0..3).map {|_i| Gosu::Image.new("media/heart.png", :tileable => true)}
  end
end