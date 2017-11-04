#encoding :utf-8

module ModeloQytetet
  class Jugador
    
    #Modificadores y consultores
    attr_accessor :casilla_actual,:encarcelado
    
    #Modificadores
    attr_writer :carta_libertad
    
    #Consultores
    attr_reader :propiedades
    
    def initialize(n)
      @encarcelado = false
      @nombre = n
      @saldo = 7500
      @propiedades = []
      @carta_libertad = nil
      @casilla_actual = nil
      
    end
    
    def actualizar_posicion
      raise "No implementado"
    end
    
    def comprar_titulo
      raise "No implementado"
    end
    #guardamos la carta en una variable auxiliar y lo tenemos a null
    def devolver_carta_libertad
      auxiliar = @carta_libertad
      @carta_libertad = nil
      #¿cómo devolver?
    end
    
    def ir_a_carcel
      raise "No implementado"
    end

    def modificar_saldo(cantidad)
      @saldo = @saldo + cantidad
    end

    def obtener_capital
      capital = @saldo
      @propiedades.each do |propied|
        capital = capital + propied.coste
        propied.titulo.each do |edificio|
          capital = capital + (edificio.precio_edificar * cuantas_casas_hoteles_tengo)
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
    
    def pagar_cobrar_por_casa_y_hotel
      raise "No implementado"
    end
    
    def pagar_libertad
      raise "No implementado"
    end
    
    def puedo_edificar_casa
      raise "No implementado"
    end
    
    def puedo_edificar_hotel
      raise "No implementado"
    end
    
    def puedo_hipotecar
      raise "No implementado"
    end
    
    def puedo_pagar_hipoteca
      raise "No implementado"
    end
   
    def puedo_vender_propiedad(casi)
      es_de_mi_propiedad(casi) && !casi.esta_hipotecada
    end
    
    def tengo_carta_libertad
      return !@carta_libertad.nil?
    end
    def tengo_propiedades
      !@propiedades.empty?
    end
    #Si es 0 no tiene propiedades, si es distinto de 0 si tiene propiedades
    def vender_propiedad
      raise "No implementado"
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
      
      cadena = "Jugador: #{@nombre}. \n"
      
      if(@encarcelado)
        cadena = cadena + "Encarcelado: sí. \n"
        
      else 
        cadena = cadena + "Encarcelado: no. \n"
      end
      
      cadena = cadena + "Saldo: #{@saldo}. \n"
      
      cadena = cadena + "Carta libertad: " + @carta_libertad.to_s + "\n"
      
      cadena = cadena + "Casilla actual: " + @casilla_actual.to_s + "\n"
      
      cadena = cadena + "Propiedades: \n"
      for s in @propiedades
        cadena = cadena + "#{s}. \n"
      end
      
      cadena
    end
    
    private :tengo_saldo, :es_de_mi_propiedad, :eliminar_de_mis_propiedades
  end
end