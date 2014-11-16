require File.expand_path("lotomania")
require File.expand_path("printer")
require File.expand_path("file_writer")

@loteria = Loteria.new
@printer = Printer.new
@writer  = FileWriter.new

@loteria.aposta
@printer.imprime(@loteria.cartoes)
@writer.gera_arquivo(@loteria.cartoes)
