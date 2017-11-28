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
    end

    def desarrollo_juego
      
      begin
        puts "Pulsa ENTER para seguir"
        gets.chomp
      
        if(@jugador.encarcelado)
          metodo = @vista.menu_salir_carcel
          @juego.intentar_salir_carcel(metodo)
        end


        if(!@jugador.encarcelado)    

          puts "Jugando."
          no_tiene_propietario = @juego.jugar
          @casilla = @jugador.casilla_actual
          
          @vista.mostrar(@jugador.to_s)
          puts "Ha jugado. \n\n"
          
          if(!@jugador.bancarrota)
            puts "No está en bancarrota. \n"

            if(!@jugador.encarcelado)
              puts "No está encarcelado.\n"
              puts @casilla.tipo
              if(@casilla.tipo == ModeloQytetet::TipoCasilla::CALLE)
                
                puts "Es una calle. \n"
                opcion = @vista.elegir_quiero_comprar

                if(opcion == 1)

                  @juego.comprar_titulo_propiedad
                  puts "Comprado."
                end

              elsif(@casilla.tipo == ModeloQytetet::TipoCasilla::SORPRESA)
                
                puts "Es una sorpresa."
                no_tiene_propietario = @juego.aplicar_sorpresa
                @vista.mostrar(@jugador.to_s)

                if(!@jugador.encarcelado && !@jugador.bancarrota && 
                   @casilla.tipo == ModeloQytetet::TipoCasilla::CALLE && no_tiene_propietario)

                  opcion = @vista.elegir_quiero_comprar

                  if(opcion == 1)

                    @juego.comprar_titulo_propiedad
                    @vista.mostrar(@jugador.to_s)
                  end
                end
              end

              if(!@jugador.encarcelado && !@jugador.bancarrota && @jugador.tengo_propiedades)

                begin

                  opcion = @vista.menu_gestion_inmobiliaria()

                  if(opcion != 0)
                    
                    @vista.mostrar(@jugador.to_s)

                    puts "Elige la propiedad: "
                    casilla = @vista.menu_elegir_propiedad(@jugador.propiedades)
                    titulo = @jugador.propiedades[casilla]

                    case opcion

                    when 1

                      res = @juego.edificar_casa(titulo.casilla)
                       
                      if(res)
                        
                        puts "Se ha edificado una casa. \n"
                        
                      else
                        
                        puts "No se ha podido edificar la casa. \n"
                      end

                    when 2

                      res = @juego.edificar_hotel(titulo.casilla)
                      
                      if(res)
                        
                        puts "Se ha edificado un hotel. \n"
                        
                      else
                        
                        puts "No se ha podido edificar el hotel. \n"
                      end

                    when 3

                      res = @juego.vender_propiedad(titulo.casilla)
                       
                      if(res)
                        
                        puts "Se ha vendido la propiedad correctamente. \n"
                        
                      else
                        
                        puts "No se ha podido vender la propiedad. \n"
                      end

                    when 4

                      res = @juego.hipotecar_propiedad(titulo.casilla)
                      
                      if(res)
                        
                        puts "Se ha hipotecado la propiedad con éxito. \n"
                        
                      else
                        
                        puts "No se ha podido hipotecar la propiedad. \n"
                      end

                    when 5

                      res = @juego.cancelar_hipoteca(titulo.casilla)
                      
                           if(res)
                        
                        puts "Se ha cancelado la hipoteca con éxito. \n"
                        
                      else
                        
                        puts "No se ha podido cancelar la hipoteca. \n"
                      end

                    end
                  end
                end while (opcion != 0)
              end  
            end
          end
        end

        if(!@jugador.bancarrota)
          
          puts "Cambiando de jugador:"
          @juego.siguiente_jugador
          @jugador = @juego.jugador_actual

        else

          puts "Fin de la partida"
          lista_ranking = @juego.obtener_ranking
          puts lista_ranking
        end
      
      end while (!@jugador.bancarrota)

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
