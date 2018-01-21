#encoding :utf-8

module ModeloQytetet
  class Casilla
    #Consultores:
    attr_reader :numero_casilla, :coste, :tipo
    
    #Modificadores y consultores: 
    attr_accessor :num_hoteles, :num_casas, :titulo
    
    
    #Constructor:
    def initialize(n, c, t)
      @numero_casilla = n
      @coste = c
      @tipo = t
    end
    
    #to_s: muestra el contenido de la casilla en pantalla:
    def to_s
      str ="Número: #{@numero_casilla}. \n"
      
      str = str +"Tipo: #{@tipo}. \n Coste: #{@coste}. \n"
      
      return str
    end
    
    #Crear casilla:
    def self.crear_casilla_normal(numero_casilla,coste,tipo)
      new(numero_casilla,coste,tipo,nil)
    end
    def self.crear_casilla_calle (numero_casilla,coste,tipo, tit)
      new(numero_casilla,coste,tipo,tit)
    end
    
    def soy_edificable
      return false
    end
    

  end
end
