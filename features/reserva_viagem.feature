#language: pt

Funcionalidade: Compra de reserva

@Compra
Cenário: Compra de reserva com sucesso
    Dado que estou na tela inicial
    E realizo uma pesquisa por passagem aérea "nacional"
    Quando insiro os dados de passageiro e dados de pagamento
    Entao a aplicação informa que a reserva está em processamento
