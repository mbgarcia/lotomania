class Loteria
  linhas  = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  colunas = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  #previos = ["12", "15", "76", "90", "54", "09", "34", "89", "01",  "06", "08",  "22", "78", "66", "43", "03", "00", "29", "07",  "82"] 

  attr_accessor :cartoes
  attr_accessor :possiveis

  def initialize
    @possiveis = []
    for i in (0..99)
      numero = i.to_s
      numero = "0" + numero unless numero.length > 1
      @possiveis << numero
    end    
  end

  def aposta
    @cartoes = []

    while @cartoes.length < 60
      cartao = ["12", "15", "76", "90", "54", "09", "34", "89", "01",  "06", "08",  "22", "78", "66", "43", "03", "00", "29", "07",  "82"] 

      while cartao.length < 50
        num = Random.rand(99)
        cartao << possiveis[num] unless cartao.include? possiveis[num]
      end

      cartao.sort!

      p @cartoes.length

      add_cartao(cartao)
    end
    
    @cartoes.sort!
  end


  def add_cartao (cartao)
    @cartoes << cartao unless @cartoes.include? cartao
  end
end