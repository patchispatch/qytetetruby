#encoding :utf-8

module ModeloQytetet
  class Casilla
    #Consultores:
    attr_reader :numero_casilla, :coste, :tipo
    
    #Modificadores y consultores: 
    attr_accessor :num_hoteles, :num_casas, :titulo
    
    
    #Constructor:
    def initialize(n, c, t, nh=0, nc=0, tp=nil)
      @numero_casilla = n
      @coste = c
      @tipo = t
      @num_hoteles = nh
      @num_casas = nc
      @titulo = tp
    end
    
    #Modificador de la propiedad:
    def titulo_propiedad(ntp)
      @titulo = ntp
    end
    
    #to_s: muestra el contenido de la casilla en pantalla:
    def to_s
      str =""
      if @tipo == :Calle
        str = str + "Tipo: #{@tipo}. \n Coste: #{@coste}. \n Propiedad de #{@titulo}. \n Número de hoteles: #{@num_hoteles}." + 
        "\n Número de casas: #{@num_casas}."
      
      else
        str = str +"Tipo: #{@tipo}. \n Coste: #{@coste}. \n"
      end
      
      return str
    end
    
    #Crear casilla:
    def self.crear_casilla_normal(numero_casilla,coste,tipo)
      new(numero_casilla,coste,tipo,nil)
    end
    def self.crear_casilla_calle (numero_casilla,coste,tipo)
      new(numero_casilla,coste,tipo)
    end
    
    
    #Métodos privados:
    private_class_method :new
    private :titulo_propiedad
  end
end
