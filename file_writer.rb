class FileWriter
    def gera_arquivo (cartoes)
      File.open("lotomania.txt", "w") do |arquivo|
        cartoes.each{ |bid|
          arquivo.write bid
          arquivo.puts ""
        }
      end
    end
end