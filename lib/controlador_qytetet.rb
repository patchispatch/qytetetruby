#encoding :utf-8

require_relative 'vista_textual_qytetet'
require_relative 'qytetet'

module InterfazTextualQytetet
  class ControladorQytetet
    def initialize
      @juego
      @jugador
      @casilla
      @vista = VistaTextualQytetet.new
    end
 
    def inicializacion_juego
      @juego = ModeloQytetet::Qytetet.instance
      nombres = @vista.obtener_nombre_jugadores
      @juego.inicializar_juego(nombres)
      @jugador = @juego.jugador_actual
      @casilla = @jugador.casilla_actual
      @vista.mostrar(@juego.to_s)
      puts "==== Jugador que comienza la partida: " 
      @vista.mostrar(@jugador.to_s)
      puts "Pulsa ENTER para seguir"
      gets.chomp
    end

    def desarrollo_juego
      if(@jugador.encarcelado)
        metodo = menu_salir_carcel
        intentar_salir_carcel(metodo)
      end
      encarcelado = @jugador.encarcelado
      if(!encarcelado)    
        
      end
    end
   
    def elegir_propiedad(propiedades) # lista de propiedades a elegir
      vista.mostrar("\tCasilla\tTitulo");
        
      listaPropiedades= Array.new
      for prop in propiedades  # crea una lista de strings con numeros y nombres de propiedades
            propString= prop.numeroCasilla.to_s+' '+prop.titulo.nombre; 
            listaPropiedades<<propString
      end
      seleccion=vista.menu_elegir_propiedad(listaPropiedades)  # elige de esa lista del menu
      propiedades.at(seleccion)
    end
 
    def self.main
      controlador = ControladorQytetet.new
      controlador.inicializacion_juego
      controlador.desarrollo_juego
    end
  end
  ControladorQytetet.main
end
