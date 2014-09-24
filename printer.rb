  require "prawn"

  class Printer

    def initialize
    end

    def imprime(cartoes)
      Prawn::Document.generate("lotomania.pdf",
                               :page_size   => "A4",
                               :layout => :portrait) do
        
        font "Courier"
        font_size 6

        largura_cartao = 229.6026
        altura_cartao  = 394.0094

        box_w = 11.3385
        box_h = 8.5039

        ver_space = 5.0039
        hor_space = 6.5848

        i = 0

        posicoes_cartao = {1 => [10, 790], 2 => [270, 790], 3 => [10, 390], 4 => [270, 390]}

        posicao_cartao = 1

        cartoes.each do |cartao| 

          fill_color "000000"

          stroke do
            posicoes_cartao.each do |indice, coordenadas|
              rectangle coordenadas, largura_cartao, altura_cartao  # cartao 1
            end
          end
    
          i +=  1
          if i % 4 == 0
            start_new_page()
          end

          document = self

          puts "cartao #{i}"
            
          cartao.each do |numero|
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

            um_x = posicoes_cartao[posicao_cartao][0] + 31.18104 + x * box_w + x * hor_space
            um_y = posicoes_cartao[posicao_cartao][1] - 218.2642 + box_h + y * ver_space + y * box_h

            posicao_cartao = posicao_cartao == 4 ? 1 : posicao_cartao +=1

            document.fill_color "00665B"
            document.fill_rectangle posicoes_cartao[posicao_cartao], box_w,  box_h

            document.fill_color "000000"
            document.fill_rectangle [um_x, um_y], box_w,  box_h
            document.fill_color "9E9E9E"
            document.draw_text numero,
              :at => [um_x, um_y - box_h / 1.5]
          end
        end
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