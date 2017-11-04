#encoding :utf-8

require 'singleton'
require_relative "dado"
require_relative "casilla"
require_relative "tablero"
require_relative "jugador"
require_relative "sorpresa"

module ModeloQytetet
  class Qytetet 
    include Singleton
    
    #Consultores
    attr_reader :carta_actual, :jugador_actual, :mazo, :jugadores, 
                :tablero, :dado
    
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
    
    def aplicar_sorpresa
      raise ""
    end
    
    def cancelar_hipoteca (casilla)
      raise ""
    end
    
    def comprar_titulo_propiedad
      raise ""
    end
    
    def edificar_casa (casilla)
      raise ""
    end
    
    def edificar_hotel (casilla)
      raise ""
    end
    
    def hipotecar_propiedad (casilla)
      raise ""
    end
    
    def inicializar_juego(nombres)

      inicializar_tablero
      inicializar_jugadores(nombres)
      inicializar_cartas_sorpresa
      salida_jugadores

    end
    
    def intentar_salir_carcel (metodo)
      raise ""
    end
    
    def jugar
      raise ""
    end
    
    def obtener_ranking (jugadores)
      raise ""
    end
    
    def propiedades_hipotecadas_jugador(hipotecadas)
      @jugador_actual.propiedades.select{|propied| propied.esta_hipotecada \
                                          == hipotecadas}
    end

    def siguiente_jugador
      posicion = @jugadores.index(@jugador_actual)
      @jugador_actual = @jugadores[(posicion+1)%@jugadores.size]
    end
    
    def vender_propiedad(casilla)
      raise ""
    end
    
    def encarcelar_jugador
      raise ""
    end
        
    def inicializar_cartas_sorpresa
      
      #Pagar-cobrar:
      
      #Pagar
      @mazo << Sorpresa.new("Recuerdas que tienes una deuda pendiente con Devi.
                Pierdes 500 dineros", -500, TipoSorpresa::PAGARCOBRAR)
      
      #Cobrar
      @mazo << Sorpresa.new("Convences a los profesores de la Universidad para 
                matricularte por... ¡-500 dineros! Los guardas en tu bolsa.",
                500, TipoSorpresa::PAGARCOBRAR)
              
      #Ir a casilla:
      
      #Parking
      @mazo << Sorpresa.new("Te sientes cansado y te apetece tomar algo, así que
                te diriges a la posada Roca de Guía",
                @tablero.parking.numero_casilla, TipoSorpresa::IRACASILLA)
      
      #Casilla aleatoria
      @mazo << Sorpresa.new("Llamas al viento sin querer y sales despedido. 
                ¡Caes en una casilla aleatoria!", 
                @tablero.impuesto.numero_casilla, TipoSorpresa::IRACASILLA)
      
      #Carcel
      @mazo << Sorpresa.new("Has quebrantado la Ley del Hierro. Debes ir a la 
                cárcel", @tablero.carcel.numero_casilla, 
                TipoSorpresa::IRACASILLA)
              
      #Pagar-cobrar por casa y hotel
      
      #Pagar
      @mazo << Sorpresa.new("Ambrose ha mandado quemar tus propiedades. La
                reparación asciende a 100 dineros por cada una.", -100, 
                TipoSorpresa::PORCASAHOTEL)
              
      #Cobrar
      @mazo << Sorpresa.new("Parece que el negocio de las posadas te va bien.
                ¡Ganas 100 dineros por cada una de tus propiedades!", 100, 
                TipoSorpresa::PORCASAHOTEL)
      
      #Pagar-cobrar por cada jugador
      
      #Pagar
      @mazo << Sorpresa.new("Pagar 150 dineros a cada jugador es del Lethani.",
                -150, TipoSorpresa::PORJUGADOR)
      
      #Cobrar
      @mazo << Sorpresa.new("Convences al resto de jugadores de que eres un 
                noble y, para tu sorpresa, ¡Cada uno te da 150 dineros", 150, 
                TipoSorpresa::PORJUGADOR)

      #Salir de la cárcel
      @mazo << Sorpresa.new("Aburrido en tu celda, decides ponerte a cantar, A
                los guardias les ha gustado, ¡y te dejan salir!", 0,
                TipoSorpresa::SALIRCARCEL)
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
      
    def salida_jugadores
      @jugadores.each do |jugador|
        jugador.casilla_actual = tablero.obtener_casilla_numero(0)
      end
      aleatorio = rand(@jugadores.size)
      
      @jugador_actual = @jugadores[aleatorio]
       
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
    
    private :encarcelar_jugador, :inicializar_cartas_sorpresa,
            :inicializar_jugadores, :inicializar_tablero, :salida_jugadores
            
  end
end
