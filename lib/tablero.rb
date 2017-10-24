#encoding :utf-8


module ModeloQytetet
  class Tablero
    
    attr_reader :carcel, :parking, :impuesto
    
    #Constructor:
    def initialize()
      @casillas = []
      @carcel = nil
      @parking = nil
      @impuesto = nil
      inicializar()
    end
    
    #Inicializar el tablero:
    def inicializar
      @casillas << Casilla.crear_casilla_normal(0,0,TipoCasilla::SALIDA)
      @casillas << Casilla.crear_casilla_calle(1,500,TipoCasilla::CALLE, 
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_calle(2,200,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_normal(3,0,TipoCasilla::SORPRESA)
      @casillas << Casilla.crear_casilla_calle(4,350,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_normal(5,0,TipoCasilla::CARCEL)
      @casillas << Casilla.crear_casilla_calle(6,400,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_calle(7,425,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_normal(8,0,TipoCasilla::IMPUESTO)
      @casillas << Casilla.crear_casilla_calle(9,300,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_normal(10,0,TipoCasilla::PARKING)
      @casillas << Casilla.crear_casilla_calle(11,650,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_calle(12,540,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_normal(13,0,TipoCasilla::SORPRESA)
      @casillas << Casilla.crear_casilla_calle(14,700,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_normal(15,0,TipoCasilla::JUEZ)
      @casillas << Casilla.crear_casilla_calle(16,250,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_calle(17,725,TipoCasilla::CALLE,
        TituloPropiedad.new())
      @casillas << Casilla.crear_casilla_normal(18,0,TipoCasilla::SORPRESA)
      @casillas << Casilla.crear_casilla_calle(19,800,TipoCasilla::CALLE,
        TituloPropiedad.new())
      
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
      raise "No implementado"
    end
    
    def obtener_casilla_numero(num)
      
      encontrado = false
      
      for i in @casillas
        
        while (!encontrado)
          
          if(num == i.numero_casilla)
            devolver = i
            encontrado = true
          end
          
        end
      end
      
      devolver
    end
    
    def obtene_nueva_casilla(cas, despl)
      raise "No implementado"
    end
    
    
    private :inicializar
  end
end