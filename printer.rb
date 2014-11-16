require "prawn"

class Printer

  def initialize
    @posicoes = {1 => [10, 790], 2 => [270, 790], 3 => [10, 390], 4 => [270, 390]}
    @posicao = 1
    @largura_cartao = 229.6026
    @altura_cartao  = 394.0094

    @box_w = 11.3385
    @box_h = 8.5039

    @pdf_point = 2.8346

    @marker = 5.6692

    @ver_space = 5.0039
    @hor_space = 6.5848

    @margin_left_blocks = 79.3688

    @pdf = Prawn::Document.new(:page_size => "A4", :layout => :portrait)
    @pdf.font "Courier"
    @pdf.font_size 6
  end

  def draw_markers
    (0..10).each do |p|
      x = @posicoes[@posicao][0] + @pdf_point
      y = @posicoes[@posicao][1] - @margin_left_blocks  - p * @ver_space - p * @box_h + @pdf_point
      @pdf.fill_rectangle [x, y] , @box_w,  @marker
    end
  end

  def desenha_borda (i)
    p = @posicoes[@posicao]
    @pdf.fill_color "000000"
    @pdf.stroke_rectangle p, @largura_cartao, @altura_cartao

    titulo = [p[0] + 40, p[1] - 20]
    @pdf.draw_text "Lotomania #{i}", :at => titulo, :size => 12
  end

  def converte_posicao(numero)
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

    [x,y]
  end

  def desenha n
    numero = converte_posicao n
    x = numero[0]
    y = numero[1]

    novo = @posicoes[@posicao]

    um_x = novo[0] + 31.18104 + x * @box_w + x * @hor_space
    um_y = novo[1] - 218.2642 + @box_h + y * @ver_space + y * @box_h

    @pdf.fill_color "00665B"
    @pdf.fill_rectangle novo, @box_w,  @box_h

    @pdf.fill_color "000000"
    @pdf.fill_rectangle [um_x, um_y], @box_w,  @box_h
    @pdf.fill_color "9E9E9E"
    @pdf.draw_text n,
      :at => [um_x, um_y - @box_h / 1.5]    
  end

  def imprime(cartoes)
    i = 1

    cartoes.each do |cartao| 

      desenha_borda i
      draw_markers

      puts "cartao #{i}"
        
      cartao.each do |numero|
        desenha numero
      end

      if i % 4 == 0
        @pdf.start_new_page()
      end

      i +=  1

      @posicao = @posicao == 4 ? 1 : @posicao +=1
    end

    @pdf.render_file "Lotomania.pdf"
  end
end