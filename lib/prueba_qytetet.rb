#encoding :utf-8

# Indicar dónde están los recursos en otros ficheros:
require_relative "tipo_sorpresa"
require_relative "sorpresa"
require_relative "tablero"
require_relative "tipo_casilla"
require_relative "casilla"
require_relative "titulo_propiedad"
require_relative "qytetet"


module ModeloQytetet
 class PruebaQytetet
   
   
  #Atributos de la clase
  #@@mazo=[]
  #@@tablero = Tablero.new
  
  ## Devuelve las sorpresas con valor mayor que 0:
  #def self.valen_mas_cero
  # @@mazo.select { |sorpresa| sorpresa.valor > 0 }
  #end
  
  ## Devuelve las sorpresas con tipo IRACASILLA:
  #def self.ir_casilla
  # @@mazo.select{ |sorpresa| sorpresa.tipo == TipoSorpresa::IRACASILLA}
  #end
  
  ## Devuelve las sorpresas con tipo especificado en el argumento:
  #def self.mostrar_cartas_tipo(t)
  # @@mazo.select{ |sorpresa| sorpresa.tipo == t}
  #end
  
  ## Métodos privados:
  #private_class_method :valen_mas_cero,:ir_casilla,:mostrar_cartas_tipo
  
  
  ###########################################################################
  # Main:
  
  def self.main 
    
    #Declaramos e inicializamos qytetet:
    #qytetet = Qytetet.instance
    #qytetet.inicializar_juego(["Vero","Juan"])
    #
    #carcel = qytetet.tablero.obtener_casilla_numero(5)
    #if qytetet.tablero.es_casilla_carcel(carcel)
    #  puts "El cacharro funciona"
    #else
    #  puts "Houston tenemos un problemilla"
    #end
    
    #nuevacasilla = qytetet.tablero.obtener_nueva_casilla(carcel, 3)
    #puts nuevacasilla.numero_casilla
    
    #puts "Probando propiedades de jugador actual " + 
    #  qytetet.propiedades_hipotecadas_jugador(true).to_s
    #puts qytetet.jugador_actual.to_s
    #qytetet.siguiente_jugador
    #puts qytetet.jugador_actual.to_s
    #qytetet.siguiente_jugador
    #puts qytetet.jugador_actual.to_s
    
    #casillaedificable = qytetet.tablero.obtener_casilla_numero(4)
    #if casillaedificable.soy_edificable
    #  puts "Soy Edificable :)"
    #else
    #  puts ":("
    #end
    
    #if carcel.soy_edificable
    #  puts "Ups"
    #else
    #  puts "Funciona Soy Edificable"
    #end

    
    #puts "Mazo: \n"
    #@@mazo.each{|carta| puts carta.to_s}
    #puts "\n\n"
    
    ## Devuelve las sorpresas con valor mayor que cero:
    #puts "Cartas con valor mayor que cero: \n"
    #muestra = valen_mas_cero()
    #muestra.each{ |sorpresa| puts sorpresa.to_s }
    #puts "\n\n" 
    
    ## Devuelve las sopresas de tipo IRACASILLA:
    #puts "Cartas de tipo IrACasilla: \n"
    #muestra = ir_casilla()
    #muestra.each do |sorpresa|
    #  puts sorpresa.to_s
    #end 
    #puts "\n\n"
    
    ## Devuelve la sorpresa de tipo especificado en el argumento:
    #@tipo = TipoSorpresa::SALIRCARCEL
    #puts "Sorpresas de tipo #{@tipo}:"
    #muestra = mostrar_cartas_tipo(@tipo)
    #muestra.each do |sorpresa|
    #  puts sorpresa.to_s
    #end
    #puts "\n\n"
    
    ## Muestra el tablero: 
    #puts "Tablero: \n"
    #puts @@tablero.to_s
    
    #Inicializamos los jugadores (provisional)
#    nombres = Array.new
#    nombres << "MJ"
#    nombres << "Juan"
#    nombres << "Pepe"
#    nombres << "Laura"
#    
#    #Inicializamos el juego:
#    qytetet.inicializar_juego(nombres)
# 
#    
#    #Mostramos qytetet:
#    puts "Qytetet: \n"
#    puts qytetet.to_s
#    
#    #Mostramos el dado de qytetet:
#    "Dado: \n"
#    puts qytetet.dado.tirar
    
    
  end

   PruebaQytetet.main
  end 
end