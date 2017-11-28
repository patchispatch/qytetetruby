#encoding :utf-8

require 'singleton'
require_relative "dado"
require_relative "casilla"
require_relative "tablero"
require_relative "jugador"
require_relative "sorpresa"
require_relative "tipo_sorpresa"

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
    
    def aplicar_sorpresa()
      
      tiene_propietario = false
      valor_carta = @carta_actual.valor
      
      if(@carta_actual.tipo == TipoSorpresa::PAGARCOBRAR)
        
        @jugador_actual.modificar_saldo(valor_carta)
      end
      
      if(@carta_actual.tipo == TipoSorpresa::IRACASILLA)
        
        es_carcel = @tablero.es_casilla_carcel(@carta_actual)
        
        if(es_carcel)
         
          encarcelar_jugador(@jugador_actual)
          
        else
          
          nueva_casilla = @tablero.obtener_casilla_numero(valor_carta)
           tiene_propietario = @jugador_actual.actualizar_posicion(nueva_casilla)
        end
      end
      
      if(@carta_actual.tipo == TipoSorpresa::PORCASAHOTEL)
        
        @jugador_actual.pagar_cobrar_por_casa_hotel(valor_carta)
      end
      
      if(@carta_actual.tipo == TipoSorpresa::PORJUGADOR)
        
        for j in @jugadores
          
          if(j != @jugador_actual)
            
            j.modificar_saldo(-valor_carta)
          end
          
          @jugador_actual.modificar_saldo(valor_carta)
        end
      end
      
      if(@carta_actual.tipo == TipoSorpresa::SALIRCARCEL)
        
        @jugador_actual.carta_libertad = @carta_actual
      end
        
        return tiene_propietario
    end
    
    def comprar_titulo_propiedad
      @jugador_actual.comprar_titulo
    end
    
    def edificar_casa (casilla)
      
      puedo_edificar = false;
      
      if(casilla.soy_edificable && casilla.se_puede_edificar_casa && 
         @jugador_actual.puedo_edificar_casa(casilla))
     
        @jugador_actual.modificar_saldo(- casilla.titulo.precio_edificar)
        casilla.edificar_casa
        puedo_edificar = true
      end
      
      puedo_edificar
    end
    
    def edificar_hotel (casilla)
      puedo_edificar = false;
      
      if(casilla.soy_edificable && casilla.se_puede_edificar_hotel && 
         @jugador_actual.puedo_edificar_hotel(casilla))
     
        @jugador_actual.modificar_saldo(- casilla.titulo.precio_edificar)
        @jugador_actual.casilla_actual.edificar_hotel
        puedo_edificar = true
      end
      
      puedo_edificar
    end
    
    def hipotecar_propiedad (casilla)
      
      puedo_hipotecar = false
      
      if(casilla.soy_edificable && !casilla.esta_hipotecada && @jugador_actual.puedo_hipotecar(casilla))
        
        @jugador_actual.modificar_saldo(casilla.hipotecar)
        puedo_hipotecar = true
      end
      
      return puedo_hipotecar
    end
    
    def inicializar_juego(nombres)

      inicializar_tablero
      inicializar_jugadores(nombres)
      inicializar_cartas_sorpresa
      salida_jugadores

    end
    
    def intentar_salir_carcel (metodo)
      encarcelado = true
      
      if(metodo == MetodoSalirCarcel::TIRANDODADO)
        valor_dado = @dado.tirar

        if(valor_dado > 5)
          encarcelado = false
          @jugador_actual.encarcelado = encarcelado
        end
      end
      
      if(metodo == MetodoSalirCarcel::PAGANDOLIBERTAD) 
        if(@jugador_actual.tengo_saldo(@@PRECIO_LIBERTAD))
          
          @jugador_actual.modificar_saldo(-@@PRECIO_LIBERTAD)
          encarcelado = false
        end

        @jugador_actual.encarcelado = encarcelado
      end
      
      encarcelado
    end
    
    def jugar
      
      valor_dado = @dado.tirar
      casilla_posicion = @jugador_actual.casilla_actual
      nueva_casilla = @tablero.obtener_nueva_casilla(casilla_posicion, valor_dado)
      tiene_propietario = @jugador_actual.actualizar_posicion(nueva_casilla)
      
      if(!nueva_casilla.soy_edificable)
        if(nueva_casilla.tipo == TipoCasilla::JUEZ)
          
          encarcelar_jugador
        end
        
        if(nueva_casilla.tipo == TipoCasilla::SORPRESA)
          
          @carta_actual = mazo[0]
        end
      end
      
      
      
      return tiene_propietario
    end
    
    def obtener_ranking ()
      
      ranking = Array.new
      
      for j in @jugadores
        
        string = "Nombre del jugador: " + j.nombre + ". "
        capital = j.obtener_capital
        string = string + "Capital: " + capital.to_s
        ranking <<  string
      end
      
      ranking
    end
    
    def propiedades_hipotecadas_jugador(hipotecadas)
      @jugador_actual.propiedades.select{|propied| propied.esta_hipotecada \
                                          == hipotecadas}
    end

    def siguiente_jugador
      posicion = @jugadores.index(@jugador_actual)
      @jugador_actual = @jugadores[(posicion+1)%@jugadores.size]
    end
    
    def cancelar_hipoteca(casilla)
        hipotecada = false
        if(casilla.esta_hipotecada)
            @jugador_actual.modificar_saldo(casilla.cancelar_hipoteca)
            hipotecada = true
        end
         hipotecada;
    end
    
    def vender_propiedad(casilla)
      puedo_vender = false
      
      if (casilla.soy_edificable)
        puedo_vender = @jugador_actual.puedo_vender_propiedad(casilla)
        
        if (puedo_vender)
          @jugador_actual.vender_propiedad(casilla)
        end
      end
      
      puedo_vender
    end
    
    def encarcelar_jugador
      
      if(!@jugador_actual.tengo_carta_libertad)
        
        casilla_carcel = @tablero.carcel
        @jugador_actual.ir_a_carcel(casilla_carcel)
      
      else
        carta_libertad = @jugador_actual.devolver_carta_libertad
        @mazo << carta_libertad

     end    
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
              
      #Barajamos:
      @mazo.shuffle
    end
    
    def inicializar_jugadores(nombres)

      @jugadores = Array.new
      
      i = 0
      
      while (i < nombres.size)
        jugador = Jugador.new(nombres[i])
        
        @jugadores << jugador
        
        i = i+1
      end
      
    end
    
    def inicializar_tablero
        @tablero = Tablero.new
    end
      
    def salida_jugadores
      @jugadores.each do |jugador|
        jugador.casilla_actual = @tablero.obtener_casilla_numero(0)
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
    
    
    def self.saldo_salida
      
      @@SALDO_SALIDA
    end
    private :encarcelar_jugador, :inicializar_cartas_sorpresa,
            :inicializar_jugadores, :inicializar_tablero, :salida_jugadores
            
  end
end
