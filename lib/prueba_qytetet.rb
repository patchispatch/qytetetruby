#encoding :utf-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

# Indicar dónde están los recursos en otros ficheros:
require_relative "tipo_sorpresa"
require_relative "sorpresa"


module ModeloQytetet
 class PruebaQytetet
   
   @@mazo=[]
   
  def self.inicializar_sorpresa
    @@mazo << Sorpresa.new("Un fan anónimo ha pagado tu fianza. Sales de la cárcel", 0, TipoSorpresa::SALIRCARCEL)
    @@mazo << Sorpresa.new("Te hemos pillado con chanclas y calcecines. Lo sentimos, ¡debes ir a la cárcel!", 9, TipoSorpresa::IRACASILLA)
  end
  
  # Devuelve las sorpresas con valor mayor que 0:
  def self.valen_mas_cero
    @@mazo.select { |sorpresa| sorpresa.valor > 0 }
  end
  
  #Devuelve las sorpresas con tipo IRACASILLA:
  def self.ir_casilla
    @@mazo.select{ |sorpresa| sorpresa.tipo == TipoSorpresa::IRACASILLA}
  end
  
  # Devuelve las sorpresas con tipo especificado en el argumento:
  def self.mostrar_cartas_tipo(t)
    @@mazo.select{ |sorpresa| sorpresa.tipo == t}
  end
  
  # Métodos privados:
  private_class_method :valen_mas_cero,:ir_casilla,:mostrar_cartas_tipo
  ###########################################################################
  # Main:
  
  def self.main
    # Inicializamos sorpresa:
    inicializar_sorpresa
    puts @@mazo.to_s
    
    # Devuelve las sorpresas con valor mayor que cero:
    muestra = valen_mas_cero()
    muestra.each{ |sorpresa| puts sorpresa.to_s }
    
    # Devuelve las sopresas de tipo IRACASILLA:
    muestra = ir_casilla()
    muestra.each do |sorpresa|
      puts sorpresa.to_s
    end
    
    # Devuelve la sorpresa de tipo especificado en el argumento:
    muestra = mostrar_cartas_tipo(TipoSorpresa::SALIRCARCEL)
    muestra.each do |sorpresa|
      puts sorpresa.to_s
    end
  end

   PruebaQytetet.main
  end 
end