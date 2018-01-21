# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module ModeloQytetet
  class Especulador < Jugador
    
    
    
    #Constructor:
    def initialize(jugador, fianza)
      super.especulador(jugador)
      @fianza = fianza
    end
    
    #Métodos:
    def pagar_impuestos(cantidad)
      modificar_saldo(-(cantidad/2))
    end
    
    def convertirme
      return self
    end
    
    def pagar_fianza
      resultado = nil
      
      if(@saldo > @fianza)
        modificar_saldo(-@fianza)
        resultado = true
        
      else
        resultado = false
      end
      
      return resultado
    end
    
    def ir_a_carcel(carcel)
      
      if(!pagar_fianza)
        super.ir_a_carcel(carcel)
      end
    end
    
    def get_factor_especulador
      return super.factor_especulador
    end

  end
  
end
