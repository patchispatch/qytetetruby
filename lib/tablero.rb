#encoding :utf-8
require_relative 'tipo_casilla'
require_relative 'titulo_propiedad'
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
      inicializar()
    end
    
    #Inicializar el tablero:
    def inicializar
      @casillas << Casilla.crear_casilla_normal(0,0,TipoCasilla::SALIDA)
      @casillas << Casilla.crear_casilla_calle(1,500,TipoCasilla::CALLE, 
        TituloPropiedad.new("Troupe de los Edena Ruh", false, 150, 0.65, 280, 250, nil, nil))
        @casillas[1].titulo.casilla = obtener_casilla_numero(1);
      @casillas << Casilla.crear_casilla_calle(2,200,TipoCasilla::CALLE,
        TituloPropiedad.new("Tarbean", false, 100, 0.75, 125, 75, nil, nil))
        @casillas[2 ].titulo.casilla  = obtener_casilla_numero(2);
      @casillas << Casilla.crear_casilla_normal(3,0,TipoCasilla::SORPRESA)
      @casillas << Casilla.crear_casilla_calle(4,350,TipoCasilla::CALLE,
        TituloPropiedad.new("El Eolio", false, 150, 0.7, 185, 175, nil, nil))
        @casillas[4 ].titulo.casilla  = obtener_casilla_numero(4);
      @casillas << Casilla.crear_casilla_normal(5,0,TipoCasilla::CARCEL)
      @casillas << Casilla.crear_casilla_calle(6,400,TipoCasilla::CALLE,
        TituloPropiedad.new("Anker's", false, 180, 0.8, 240, 200, nil, nil))
        @casillas[6 ].titulo.casilla  = obtener_casilla_numero(6);
      @casillas << Casilla.crear_casilla_calle(7,425,TipoCasilla::CALLE,
        TituloPropiedad.new("El Archivo", false, 195, 0.7, 220, 210, nil, nil))
        @casillas[7 ].titulo.casilla  = obtener_casilla_numero(7);
      @casillas << Casilla.crear_casilla_normal(8,0,TipoCasilla::IMPUESTO)
      @casillas << Casilla.crear_casilla_calle(9,300,TipoCasilla::CALLE,
        TituloPropiedad.new("La Clínica", false, 100, 0.65, 120, 110, nil, nil))
        @casillas[9 ].titulo.casilla  = obtener_casilla_numero(9);
      @casillas << Casilla.crear_casilla_normal(10,0,TipoCasilla::PARKING)
      @casillas << Casilla.crear_casilla_calle(11,650,TipoCasilla::CALLE,
        TituloPropiedad.new("La Factoría", false, 200, 0.9, 320, 280, nil, nil))
        @casillas[11 ].titulo.casilla  = obtener_casilla_numero(11);
      @casillas << Casilla.crear_casilla_calle(12,540,TipoCasilla::CALLE,
        TituloPropiedad.new("La Subrealidad", false, 180, 0.75, 240, 210, nil, nil))
        @casillas[12 ].titulo.casilla  = obtener_casilla_numero(12);
      @casillas << Casilla.crear_casilla_normal(13,0,TipoCasilla::SORPRESA)
      @casillas << Casilla.crear_casilla_calle(14,700,TipoCasilla::CALLE,
        TituloPropiedad.new("Ademre", false, 300, 0.8, 350, 310, nil, nil))
        @casillas[14 ].titulo.casilla  = obtener_casilla_numero(14);
      @casillas << Casilla.crear_casilla_normal(15,0,TipoCasilla::JUEZ)
      @casillas << Casilla.crear_casilla_calle(16,250,TipoCasilla::CALLE,
        TituloPropiedad.new("Modeg", false, 120, 0.65, 170, 150, nil, nil))
        @casillas[16 ].titulo.casilla  = obtener_casilla_numero(16);
      @casillas << Casilla.crear_casilla_calle(17,725,TipoCasilla::CALLE,
        TituloPropiedad.new("Trebon", false, 300, 0.9, 320, 310, nil, nil))
        @casillas[17 ].titulo.casilla  = obtener_casilla_numero(17);
      @casillas << Casilla.crear_casilla_normal(18,0,TipoCasilla::SORPRESA)
      @casillas << Casilla.crear_casilla_calle(19,800,TipoCasilla::CALLE,
        TituloPropiedad.new("El mundo de los Fata", false, 380, 0.8, 420, 400, nil, nil))
        @casillas[19 ].titulo.casilla  = obtener_casilla_numero(19);
      
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