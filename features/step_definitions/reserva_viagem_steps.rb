Dado("que estou na tela inicial") do
  visit('https://www.viajanet.com.br/')
end

Dado("realizo uma pesquisa por passagem aérea {string}") do |destino|
  @utils.pesquisar(destino)
end

Quando("insiro os dados de passageiro e dados de pagamento") do
    @utils.preencher_dados_compra
end

Então("a aplicação informa que a reserva está em processamento") do
    @utils.assertReserva
end