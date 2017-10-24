#encoding :utf-8

module ModeloQytetet
  class Jugador
    
    attr_accessor :casilla_actual,:encarcelado
    attr_writer :carta_libertad
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
    
    def devolver_carta_libertad
      raise "No implementado"
    end
    
    def ir_a_carcel
      raise "No implementado"
    end
    
    def modificar_saldo
      raise "No implementado"
    end
    
    def obtener_capital
      raise "No implementado"
    end
    
    def obtener_propiedades_hipotecadas
      raise "No implementado"
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
    
    def puedo_vender_propiedad
      raise "No implementado"
    end
    
    def tengo_carta__libertad
      raise "No implementado"
    end
    
    def vender_propiedad
      raise "No implementado"
    end
    
    def cuantas_casas_hoteles_tengo
      raise "No implementado"
    end
    
    def eliminar_de_mis_propiedades
      raise "No implementado"
    end
    
    def es_de_mi_propiedad
      raise "No implementado"
    end
    
    def tengo_saldo
      raise "No implementado"
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
