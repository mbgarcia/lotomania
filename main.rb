require File.expand_path("lotomania")
require File.expand_path("printer")

@loteria = Loteria.new
@loteria.aposta
@printer = Printer.new
@printer.imprime(@loteria.cartoes)
@printer.gera_arquivo(@loteria.cartoes)