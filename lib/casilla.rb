#encoding :utf-8

module ModeloQytetet
  class Casilla
    #Consultores:
    attr_reader :numero_casilla, :coste, :tipo
    
    #Modificadores y consultores: 
    attr_accessor :num_hoteles, :num_casas, :titulo
    
    
    #Constructor:
    def initialize(n, c, t, tp=nil, nh=0, nc=0)
      @numero_casilla = n
      @coste = c
      @tipo = t
      @num_hoteles = nh
      @num_casas = nc
      @titulo = asignar_titulo_propiedad(tp)
    end
    
    #Modificador de la propiedad:
    def titulo_propiedad(ntp)
      @titulo = ntp
    end
    
    #to_s: muestra el contenido de la casilla en pantalla:
    def to_s
      str =""
      if @tipo == :Calle
        str = str + "Tipo: #{@tipo}. \n Coste: #{@coste}. \n Propiedad de #{@titulo}. \n Número de hoteles: #{@num_hoteles}." + 
        "\n Número de casas: #{@num_casas}."
      
      else
        str = str +"Tipo: #{@tipo}. \n Coste: #{@coste}. \n"
      end
      
      return str
    end
    
    #Crear casilla:
    def self.crear_casilla_normal(numero_casilla,coste,tipo)
      new(numero_casilla,coste,tipo,nil)
    end
    def self.crear_casilla_calle (numero_casilla,coste,tipo, tit)
      new(numero_casilla,coste,tipo,tit)
    end
    
    def asignar_propietario(jugador)
      @titulo.propietario = jugador
    end
    
    def calcular_valor_hipoteca
      raise "No implementado"
    end
    
    def cancelar_hipoteca
      raise "No implementado"
    end
    
    def cobrar_alquiler
      coste_alquiler = (titulo.alquiler_base + (@num_casas * 0.5) + (@num_hoteles * 2)).to_i
      @titulo.propietario.modificar_saldo(coste_alquiler)
      
      coste_alquiler
      
    end
    
    def edificar_casa
      @num_casas = @num_casas + 1
    end
    
    def edificar_hotel
      raise "No implementado"
    end

    def esta_hipotecada
      return @titulo.hipotecada 
    end
    
    def hipotecar
      
      hipo = @titulo.hipoteca_base
      
      @titulo.hipotecada = true;
      valor_hipoteca = hipo + ((@num_casas * 0.5 * hipo)
                       + (@num_hoteles * hipo)).to_i
                     
      return valor_hipoteca
    end
    #Suma de coste, suma de precio casa y hoteles * lo que cuesta edificar
    def precio_total_comprar
      raise "No implementado"
    end
    
    def propietario_encarcelado 
      raise "No implementado"
    end
    
    def se_puede_edificar_casa
     
      resultado = false
      
      if(@num_casas < 4)
        resultado = true
      end
      
      resultado
    end
    
    def se_puede_edificar_hotel
      raise "No implementado"
    end

    def soy_edificable
      @tipo == TipoCasilla::CALLE
    end
    
    def tengo_propietario
      resultado = false
      
      if(@titulo.tengo_propietario())
        resultado = true
      end
      
      resultado
    end
    
    def vender_titulo
      raise "No implementado"
    end
    
    def asignar_titulo_propiedad(tp)
      @titulo = tp
      #this.setCasilla()
    end
    
    
    #Métodos privados:
    private_class_method :new
    private :titulo_propiedad
  end
end
