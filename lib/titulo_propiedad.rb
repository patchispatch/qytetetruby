#encoding :utf-8

module ModeloQytetet
  class TituloPropiedad
    #Consultores
    attr_reader :nombre, :alquiler_base, :factor_revalorizacion, :hipoteca_base, :precio_edificar
    attr_accessor :hipotecada
    
    #Constructor:
    def initialize(n=nil, h=nil, ab=nil, fr=nil, hb=nil, pe=nil)
      @nombre = n
      @hipotecada = h
      @alquiler_base = ab
      @factor_revalorizacion = fr
      @hipoteca_base = hb
      @precio_edificar = pe
    end
    
    def to_s
      "Nombre: #{@nombre}. \n Hipotecada: #{@hipotecada}. \n Alquiler base: #{@alquiler_base}. \n" + 
      "Factor de revalorización: #{@factor_revalorizacion}. \n Hipoteca base: #{@hipoteca_base}. \n" + 
      "Precio de edificación: #{@precio_edificar}."
    end
    
    def propietario_encarcelado
      raise "No implementado"
    end
    
    def tengo_propietario
      raise "No implementado"
    end
    
  end
end
