#encoding :utf-8

require "singleton"
require_relative "dado"
require_relative "casilla"
require_relative "tablero"
require_relative "jugador"
require_relative "sorpresa"

module ModeloQytetet
  class Qytetet
    
    include Singleton
    
    attr_reader :carta_actual, :jugador_actual, :mazo, :jugadores, :tablero, :dado
    
    #Constantes:
    @@MAX_JUGADORES = 4
    @@MAX_CARTAS = 10
    @@MAX_CASILLAS = 20
    @@PRECIO_LIBERTAD = 200
    @@SALDO_SALIDA = 1000
    
    def initialize()
      #Atributos de referencia:
      @dado = Dado.instance
      @tablero
      @jugador_actual = nil
      @jugadores
      @carta_actual = nil
      @mazo = []
    end
    
    
    def inicializar_cartas_sorpresa
      @mazo << Sorpresa.new("Un fan anónimo ha pagado tu fianza. Sales de 
      la cárcel", 0, TipoSorpresa::SALIRCARCEL)

      @mazo << Sorpresa.new("Te hemos pillado con chanclas y calcecines. 
      Lo sentimos, ¡debes ir a la cárcel!", @tablero.carcel.numero_casilla, 
      TipoSorpresa::IRACASILLA)

      @mazo << Sorpresa.new("Cobrar 500", 500, TipoSorpresa::PAGARCOBRAR)

      @mazo << Sorpresa.new("Pagar 500", -500, TipoSorpresa::PAGARCOBRAR)

      @mazo << Sorpresa.new("Ir al párking", @tablero.parking.numero_casilla, 
        TipoSorpresa::IRACASILLA)

      @mazo << Sorpresa.new("Ir a impuesto", @tablero.impuesto.numero_casilla, 
        TipoSorpresa::IRACASILLA)

      @mazo << Sorpresa.new("Cobrar 100 por casa y hotel", 100, 
        TipoSorpresa::PORCASAHOTEL)

      @mazo << Sorpresa.new("Cobrar 150 por jugador", 150, 
        TipoSorpresa::PORJUGADOR)

      @mazo << Sorpresa.new("Pagar 100 por casa y hotel", -100, 
        TipoSorpresa::PORCASAHOTEL)

      @mazo << Sorpresa.new("Pagar 150 por jugador", -150, 
        TipoSorpresa::PORJUGADOR)
    end
    
    def inicializar_jugadores(nombres)

      @jugadores = Array.new
      
      i = 0
      
      while (i < nombres.size)
        #Se crea una variable local para poner el jugador en la salida.
        jugador = Jugador.new(nombres[i])
        jugador.casilla_actual = @tablero.obtener_casilla_numero(0)
        
        @jugadores << jugador
        
        i = i+1
      end
    end
    
    def inicializar_tablero
        @tablero = Tablero.new
      end
      
    def inicializar_juego(nombres)

      inicializar_tablero
      inicializar_jugadores(nombres)
      inicializar_cartas_sorpresa

    end
    
    def to_s
      cadena = "Tablero: " + @tablero.to_s
      
      for j in @jugadores
        cadena = cadena + "Jugador: \n" + j.to_s
      end
      
      if(@jugador_actual != nil && @carta_actual != nil)
        cadena = cadena + "Jugador_actual: " + @jugador_actual.to_s + "\n"
        cadena = cadena + "Carta_actual: " + @carta_actual.to_s + "\n"
      end
      
      cadena = cadena + "Mazo: \n"
      for i in @mazo
        cadena = cadena + i.to_s + "\n"
      end
      
      cadena
    end
    
    private :inicializar_tablero, :inicializar_jugadores, :inicializar_cartas_sorpresa
  end
end
