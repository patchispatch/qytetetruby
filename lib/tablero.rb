#encoding :utf-8
require_relative 'tipo_casilla'
require_relative 'titulo_propiedad'
require_relative 'casilla'
require_relative 'calle'
module ModeloQytetet
  class Tablero
    
    #Consultores
    attr_reader :carcel, :parking, :impuesto
    
    #Constructor:
    def initialize()
      @casillas = []
      @carcel = nil
      @parking = nil
      @impuesto = nil
      inicializar
    end
    
    #Inicializar el tablero:
    def inicializar
      @casillas << Casilla.new(0,0,TipoCasilla::SALIDA)
      
      titulo = TituloPropiedad.new("Calle Richard Widmark", false, 150, 0.65, 280, 250, nil, nil)
      @casillas << Calle.new(1,500,TipoCasilla::CALLE, titulo)
      
      titulo = TituloPropiedad.new("El Piso", false, 100, 0.75, 125, 75, nil, nil)
      @casillas << Calle.new(2,200,TipoCasilla::CALLE, titulo)
      
      @casillas << Casilla.new(3,0,TipoCasilla::SORPRESA)
      
      titulo = TituloPropiedad.new("La ETSIIT", false, 150, 0.7, 185, 175, nil, nil)
      @casillas << Calle.new(4,350,TipoCasilla::CALLE, titulo)
      
      @casillas << Casilla.new(5,0,TipoCasilla::CARCEL)
      
      titulo = TituloPropiedad.new("La Taberna", false, 180, 0.8, 240, 200, nil, nil)
      @casillas << Calle.new(6,400,TipoCasilla::CALLE, titulo)
      
      
      titulo = TituloPropiedad.new("Calle algo", false, 195, 0.7, 220, 210, nil, nil)
      @casillas << Calle.new(7,425,TipoCasilla::CALLE, titulo)
      
      @casillas << Casilla.new(8,0,TipoCasilla::IMPUESTO)
      
      titulo = TituloPropiedad.new("El centro de salud que no me gusta", false, 100, 0.65, 120, 110, nil, nil)
      @casillas << Calle.new(9,300,TipoCasilla::CALLE, titulo)
      
      @casillas << Casilla.new(10,0,TipoCasilla::PARKING)
      
      titulo = TituloPropiedad.new("Hotel mango", false, 200, 0.9, 320, 280)
      @casillas << Calle.new(11,650,TipoCasilla::CALLE, titulo)
      
      titulo = TituloPropiedad.new("Calle Neptuno", false, 180, 0.75, 240, 210)
      @casillas << Calle.new(12,540,TipoCasilla::CALLE, titulo)
      
      @casillas << Casilla.new(13,0,TipoCasilla::SORPRESA)
      
      titulo = TituloPropiedad.new("El piso de Alberto", false, 300, 0.8, 350, 310)
      @casillas << Calle.new(14,700,TipoCasilla::CALLE, titulo)
      
      @casillas << Casilla.new(15,0,TipoCasilla::JUEZ)
      
      titulo = TituloPropiedad.new("El mundo de Tarzan de KH1", false, 120, 0.65, 170, 150)
      @casillas << Calle.new(16,250,TipoCasilla::CALLE, titulo)
      
      titulo = TituloPropiedad.new("Un game donde venden chain of memories", false, 300, 0.9, 320, 310)
      @casillas << Calle.new(17,725,TipoCasilla::CALLE, titulo)
      
      @casillas << Casilla.new(18,0,TipoCasilla::SORPRESA)
      
      titulo = TituloPropiedad.new("Casa de la abuela", false, 380, 0.8, 420, 400)
      @casillas << Calle.new(19,800,TipoCasilla::CALLE, titulo)
      
      @carcel = @casillas[5]
      @parking = @casillas[10]
      @impuesto = @casillas[8]
    end
    
    #to_s:
    def to_s
      str = ""
      @casillas.each{|casi| str = str + casi.to_s + "\n\n"}
      return str
    end

    def es_casilla_carcel(cas)
      return cas == @carcel
    end
    
    def obtener_casilla_numero(num)
      return @casillas[num]
    end
    
    def obtener_nueva_casilla(cas, despl)
      return @casillas[(cas.numero_casilla+despl)%20]
    end
    
    
    private :inicializar
  end
end