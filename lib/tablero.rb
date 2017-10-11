#encoding :utf-8


module ModeloQytetet
  class Tablero
    
    attr_reader :carcel
    #Constructor:
    def initialize()
      @casillas = []
      @carcel = nil
      inicializar()
    end
    
    #Inicializar el tablero:
    def inicializar
      @casillas << Casilla.crear_casilla_normal(0,0,TipoCasilla::SALIDA)
      @casillas << Casilla.crear_casilla_calle(1,200,TipoCasilla::CALLE)
      @casillas << Casilla.crear_casilla_normal(4,0,TipoCasilla::CARCEL)
      @casillas << Casilla.crear_casilla_calle(1,200,TipoCasilla::CALLE)
      @casillas << Casilla.crear_casilla_normal(5,0,TipoCasilla::SORPRESA)
      @casillas << Casilla.crear_casilla_calle(11,1000,TipoCasilla::CALLE)
      @carcel = @casillas[4]
    end
    
    #to_s:
    def to_s
      str = ""
      @casillas.each{|casi| str = str + casi.to_s + "\n\n"}
      return str
    end
    
    private :inicializar
  end
end