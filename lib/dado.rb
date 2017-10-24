#encoding :utf-8

require "singleton"

module ModeloQytetet
  class Dado
    
    include Singleton
    
    def initialize
      
    end
    
    def tirar
      aleatorio = rand(6)
      alatorio = aleatorio + 1
    end
  end
end
