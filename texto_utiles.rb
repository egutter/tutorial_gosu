module TextoUtiles
  def centrar_texto(fuente, texto)
    ancho_texto = fuente.text_width(texto) / 2
    Juego::MITAD_PANTALLA_ANCHO - ancho_texto
  end
end