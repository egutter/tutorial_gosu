class Ascelerar
  
  MOVIMIENTOS = [:adelante, :atras, :quieto]
  
  def initialize(nave)
    @nave = nave
    @segundos_para_moverse = rand(5..10)
    @tiempo_de_ejecucion_movimiento = tiempo_actual_en_segundos + @segundos_para_moverse
    @movimiento = MOVIMIENTOS[rand(3)]
  end

  def ejecutar
    termino_movimiento = tiempo_actual_en_segundos > @tiempo_de_ejecucion_movimiento
    if termino_movimiento
      Girar.new(@nave)
    else
      @nave.ascelerar if @movimiento == :adelante
      @nave.retroceder if @movimiento == :atras
      self
    end
  end

  private

  def tiempo_actual_en_segundos
    Time.now.to_i
  end
end

class Girar
  MOVIMIENTOS = [:derecha, :izquierda]
  def initialize(nave)
    @nave = nave
    @giros = rand(5..10)
    @movimiento = MOVIMIENTOS[rand(2)]
    puts "Girar #{@movimiento}"
  end

  def ejecutar
    (1..@giros).each do
      @nave.girar_derecha if @movimiento == :derecha
      @nave.girar_izquierda if @movimiento == :izquierda
    end
    Ascelerar.new(@nave)
  end
end

class Disparo
  def initialize(nave)
    @nave = nave
    @segundos_para_disparar = rand(2..5)
    @tiempo_espera_para_disparar = tiempo_actual_en_segundos + @segundos_para_disparar
  end

  def disparar
    if (tiempo_actual_en_segundos > @tiempo_espera_para_disparar)
      @nave.disparar
      @segundos_para_disparar = rand(2..5)
      @tiempo_espera_para_disparar = tiempo_actual_en_segundos + @segundos_para_disparar
    end
  end

  private

  def tiempo_actual_en_segundos
    Time.now.to_i
  end
end
class NaveControladaPorComputadora < Imperio

  NOMBRES = ["Darth Vader", "Kylo Ren", "Moff Gideon"]
  
  def initialize
    super(NOMBRES[rand(NOMBRES.size)])
    @disparo = Disparo.new(self)
    @movimiento_actual = Girar.new(self)
  end
  
  def mover_jugador
    @disparo.disparar
    @movimiento_actual = @movimiento_actual.ejecutar
    self.mover
  end

  def volver_empezar
    super
    @disparo = Disparo.new(self)
  end
end