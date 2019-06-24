require 'ffaker'
require 'cpf_cnpj'

INFO = { dados_cadastro: {
                      cpf: CPF.generate,
                      nome: FFaker::NameBR.first_name,
                      sobrenome: FFaker::NameBR.last_name,
                      email: FFaker::Internet.free_email,
                      telefone: FFaker::PhoneNumberBR.phone_number
                  }
}