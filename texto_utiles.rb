module TextoUtiles
  def centrar_texto(fuente, texto)
    ancho_texto = fuente.text_width(texto) / 2
    Juego::MITAD_PANTALLA_ANCHO - ancho_texto
  end

  def mouse_click_adentro_de_objeto(objeto, objeto_x, objeto_y, juego)
    objeto_fin_x = objeto_x + objeto.width
    objeto_fin_y = objeto_y + objeto.height
    
    mouse_dentro_objeto_x = (juego.mouse_x >= objeto_x && juego.mouse_x <= objeto_fin_x)
    mouse_dentro_objeto_y = (juego.mouse_y >= objeto_y && juego.mouse_y <= objeto_fin_y)

    return mouse_dentro_objeto_x && mouse_dentro_objeto_y
  end
end