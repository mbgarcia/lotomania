require "prawn"

class Printer

  def initialize
    @custom_size = [232.4376, 396.8496]
  end


  def imprime(cartoes)
    Prawn::Document.generate("lotomania.pdf",
                             :page_size   => @custom_size) do
      font "Courier"
      font_size 6

    box_w = 11.3385
    box_h = 8.5039

    ver_space = 5.0039
    hor_space = 6.5848

    px = 11.3385
    py = 8.5039  



      cartoes.each{ |cartao| 

        start_new_page(:size => @custom_size, 
            :layout => :portrait, 
            :left_margin => 31.18104,
            :top_margin => 93.5424,
            :bottom_margin => 175.7448)

        document = self
        
        cartao.each{ |numero|
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
      }
    end
  end

  def gera_arquivo (cartoes)
    File.open("lotomania.txt", "w") do |arquivo|
      cartoes.each{ |bid|
        arquivo.write bid
        arquivo.puts ""
      }
    end
  end
end