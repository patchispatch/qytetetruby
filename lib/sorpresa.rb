#encoding :utf-8

module ModeloQytetet
  class Sorpresa
    #Consultores:
    attr_reader :texto,:valor,:tipo
    
    # Inicializa la clase (t: texto, v: valor, tp: tipo):
    def initialize(t, v, tp)
      @texto = t
      @valor = v
      @tipo = tp

    end
    
    #ToString:
    def to_s
      "Texto: #{@texto} \n Valor: #{@valor} \n Tipo: #{@tipo}"
    end 
  end
end