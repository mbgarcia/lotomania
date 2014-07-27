require "prawn"

class Loteria
  bids = []

  attr_accessor :bids

  def add_bid (bid)
    bids << bid unless bids.include? bid
  end

  def imprime(document, bid)
    custom_size = [232.4376, 396.8496]

    box_w = 11.3385
    box_h = 8.5039

    ver_space = 5.0039
    hor_space = 6.5848

    px = 11.3385
    py = 8.5039  

    document.start_new_page(:size => custom_size, 
        :layout => :portrait, 
        :left_margin => 31.18104,
        :top_margin => 93.5424,
        :bottom_margin => 175.7448)

    bid.each{ |numero|
      x = numero[1].to_i 
      y = numero[0].to_i

      if x == 0
        x = 9
      else
        x = x - 1
      end

      if numero.to_i % 10 == 0
        y = 10 - y
      else
        y = 9 - y
      end

      if numero == "00"
        x = 9
        y = 0
      end

      um_y = py + y * ver_space + y * box_h
      um_x = x * px + x * hor_space

      document.fill_color "000000"
      document.fill_rectangle [um_x, um_y], box_w,  box_h
      document.fill_color "5E5B5B"
      document.draw_text numero,
        :at => [um_x, um_y - box_h / 1.5]
    }
  end 

  def gera
    Prawn::Document.generate("lotomania.pdf",
                             :page_size   => "EXECUTIVE",
                             :page_layout => :landscape) do
      document = self

      font "Courier"
      font_size 6

      linhas  = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      colunas = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

      stroke_axis

      numeros = []

      for i in (0..99)
        numero = i.to_s
        numero = "0" + numero unless numero.length > 1
        numeros << numero
      end

      previos = ["12", "15", "76", "90", "54", "9", "34", "89", "1",  "6", "8",  "22", "78", "66", "43", "3", "00", "29", "7",  "82"] 

      @loteria = Loteria.new

      @loteria.bids = []

      while @loteria.bids.length < 60
        aposta = ["12", "15", "76", "90", "54", "09", "34", "89", "01",  "06", "08",  "22", "78", "66", "43", "03", "00", "29", "07",  "82"] 

        while aposta.length < 50
          num = Random.rand(99)
          aposta << numeros[num] unless aposta.include? numeros[num]
        end

        aposta.sort!

        p @loteria.bids.length

        @loteria.add_bid(aposta)
      end

      @loteria.bids.sort!

      @loteria.bids.each{ |bid| 
        @loteria.imprime(document, bid)
      }

      File.open("lotomania.txt", "w") do |arquivo|
        @loteria.bids.each{ |bid|
          arquivo.write bid
          arquivo.puts ""
        }
      end
    end    
  end
end

@loteria = Loteria.new
@loteria.gera