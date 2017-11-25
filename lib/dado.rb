#encoding :utf-8

require "singleton"

module ModeloQytetet
  class Dado
    
    include Singleton
    
    def initialize
      
    end
    
    def tirar
      aleatorio = rand(6)
      aleatorio = aleatorio + 1
      
      puts "Valor del dado: #{aleatorio}. \n"
      
      aleatorio
    end
  end
end
