#encoding :utf-8

module ModeloQytetet
  class Jugador
    
    #Modificadores y consultores
    attr_accessor :casilla_actual,:encarcelado
    
    #Modificadores
    attr_writer :carta_libertad
    
    #Consultores
    attr_reader :propiedades, :nombre
    
    #Variables de clase:
    @@factor_especulador = 1
    
    #Métodos:
    def initialize(n)
      @encarcelado = false
      @nombre = n
      @saldo = 7500
      @propiedades = Array.new
      @carta_libertad = nil
      @casilla_actual = nil
    end
    
    def self.especulador(jugador)
      @@factor_especulador = 2
      @nombre = jugador.nombre
      @saldo = jugador.saldo
      @propiedades = jugador.propiedades
      @carta_libertad = jugador.carta_libertad
      @casilla_actual = jugador.casilla_actual
    end
    
    def get_factor_especulador
      return @@factor_especulador
    end
    
    def actualizar_posicion(casilla)
      
      if(casilla.numero_casilla < @casilla_actual.numero_casilla)
        
        modificar_saldo(Qytetet.saldo_salida)
      end
      
      tengo_propietario = false
      @casilla_actual = casilla
      
      if(casilla.soy_edificable)
          if(casilla.tengo_propietario && casilla.titulo.propietario_encarcelado)
            coste_alquiler = casilla.cobrar_alquiler()
            modificar_saldo(-coste_alquiler)
          end
      end
      
      if(casilla.tipo == TipoCasilla::IMPUESTO)
        coste = casilla.coste
        modificar_saldo(-coste)
      end
      
      return tengo_propietario
    end
    
    def comprar_titulo
      
      puedo_comprar = false
      coste_compra = @casilla_actual.coste
      
      if(@casilla_actual.soy_edificable && !@casilla_actual.tengo_propietario && coste_compra<= @saldo)
        
        @casilla_actual.asignar_propietario(self)
        @propiedades << @casilla_actual.titulo
        modificar_saldo(-coste_compra)
        
        puedo_comprar = true
      end
      
      puedo_comprar
    end
    
    #guardamos la carta en una variable auxiliar y lo tenemos a null
    def devolver_carta_libertad
      auxiliar = @carta_libertad
      @carta_libertad = nil
      
      return auxiliar
      
    end
    
    def ir_a_carcel(carcel)
      
      @casilla_actual = carcel
      @encarcelado = true
    end

    def modificar_saldo(cantidad)
      
      @saldo = @saldo + cantidad
    end

    def obtener_capital
      capital = @saldo
      @propiedades.each do |propied|
        capital = capital + propied.coste
        propied.titulo.each do |edificio|
          capital = capital + (edificio.precio_edificar * cuantas_casas_hoteles_tengo())
          if (propied.esta_hipotecada)
            capital = capital - propied.hipoteca_base
          end
        end
      end
      
      return capital
    end
   
    def obtener_propiedades_hipotecadas(hipotecadas)
      @propiedades.select { |propied|  propied.hipotecada == hipotecadas}
    end
    
    def pagar_cobrar_por_casa_y_hotel(cantidad)
      
      numero_total = cuantas_casas_hoteles_tengo()
      modificar_saldo(cantidad * numero_total)
    end
    
    def pagar_libertad
      raise "No implementado"
    end
    
    def puedo_edificar_casa(casilla)
      
      resultado = false
      
      if(es_de_mi_propiedad(casilla))
        
        coste_edificar_casa = casilla.titulo.precio_edificar
        
        if(tengo_saldo(coste_edificar_casa))
          
          resultado = true
        end
      end
      
      resultado
    end
    
    def puedo_edificar_hotel(casilla)
       resultado = false
      
      if(es_de_mi_propiedad(casilla))
        
        coste_edificar_hotel = casilla.titulo.precio_edificar
        
        if(tengo_saldo(coste_edificar_hotel))
          
          resultado = true
        end
      end
      
      resultado
    end
    
    def puedo_hipotecar(casilla)
      
      es_de_mi_propiedad(casilla)
    end
    
    def puedo_pagar_hipoteca
      raise "No implementado"
    end
   
    def puedo_vender_propiedad(casi)
      puedo_vender = false
      
      if (es_de_mi_propiedad(casi) && !casi.titulo.hipotecada)
        puedo_vender = true
      end
      
      puedo_vender
    end
    
    def tengo_carta_libertad
      return !@carta_libertad.nil?
    end
    def tengo_propiedades
      
      !@propiedades.empty?
    end
    
    #Si es 0 no tiene propiedades, si es distinto de 0 si tiene propiedades
    def vender_propiedad(casilla)
      precio_venta = casilla.vender_titulo()
      modificar_saldo(precio_venta)
      
      eliminar_de_mis_propiedades(casilla)
    end
    
    def cuantas_casas_hoteles_tengo
      @propiedades.count{|propied| propied.num_hoteles > 0 || \
                            propied.num_casas > 0}
    end
 
    def eliminar_de_mis_propiedades(casi)
      @propiedades.delete(casi.titulo)
    end

    def es_de_mi_propiedad(casi)
      a = @propiedades.find_index { |propied| propied==casi.titulo}
      return ! a.nil?
    end

    def tengo_saldo(cantidad)
     @saldo >= cantidad
    end
    
    def to_s
      
      #Cambiar "Jugador" por self.class.name.
      
      cadena = "Jugador: #{@nombre}. \n"
      
      if(@encarcelado)
        cadena = cadena + "Encarcelado: sí. \n"
        
      else 
        cadena = cadena + "Encarcelado: no. \n"
      end
      
      cadena = cadena + "Saldo: #{@saldo}. \n"
      
      cadena = cadena + "Carta libertad: " + @carta_libertad.to_s + "\n"
      
      cadena = cadena + "Casilla actual: " + @casilla_actual.to_s
      
      cadena = cadena + "Propiedades: \n"
      
      for s in @propiedades
        cadena = cadena + "#{s}. \n"
      end
      
      cadena = cadena + "\n"
      
      cadena
    end
    
    def bancarrota
      arruinado = false
      
      if(@saldo <= 0)
        arruinado = true
      end
      
      return arruinado
    end
    
    def pagar_impuestos(cantidad)
      modificar_saldo(-cantidad)
    end
    
    def convertirme(fianza)
      converso = converso.especulador(self, fianza)
      
      return converso
    end
    
    private :es_de_mi_propiedad, :eliminar_de_mis_propiedades
  end
end
