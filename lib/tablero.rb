#encoding :utf-8


module ModeloQytetet
  class Tablero
    #Constructor:
    def initialize()
      @casillas = []
      @carcel = nil
      inicializar()
    end
    
    #Inicializar el tablero:
    def inicializar
      @casillas << Casilla.new(0,0,TipoCasilla::SALIDA)
      @casillas << Casilla.new(1,200,TipoCasilla::CALLE)
      @casillas << Casilla.new(4,0,TipoCasilla::CARCEL)
      #...
      #...
      #...
      @carcel = @casillas[4]
    end
    
    #to_s:
    def to_s
      @casillas.each{|casi| puts casi.to_s}
    end
    
    private :inicializar
  end
end