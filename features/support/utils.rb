class Utils
    
    def fechar_modal
    within(ELEMENTS['modal_home']) do
        find(ELEMENTS['button_modal_x']).click 
        end
    end

    def pesquisar(destino)
        fechar_modal
        send("preencher_destino_#{destino}")
        preencher_data
        selecionar_voo
    end

    def preencher_data
        find(ELEMENTS['text_data_ida']).click
        3.times do # TODO - por enquanto não parametrizável - seleciona o mês de outubro (3 meses pra frente)
            find(ELEMENTS['button_proximo_mes']).click
            end
        find(ELEMENTS['button_dia_ida']).click
        find(ELEMENTS['button_dia_volta']).click
    end

    def preencher_destino_nacional
        $destinoNacional = Massa['Destinos_Nacionais'].sample
        find(ELEMENTS['text_destino']).set($destinoNacional)
        find(ELEMENTS['text_destino']).send_keys(:enter) if has_selector?(ELEMENTS['lista_destinos'], visible: true)
    end

    def preencher_destino_internacional
        $destinoInternacional = Massa['Destinos_Internacionais'].sample
        find(ELEMENTS['text_destino']).set($destinoInternacional)
    end

    def selecionar_voo
        find(ELEMENTS['button_pesquisar']).click
        assert_selector(ELEMENTS['btn_comprar'], wait: 60)
        first(ELEMENTS['btn_comprar']).click
        find('.md-close').click if has_selector?('.md-content')
    end

    def mudar_aba
        result = page.driver.browser.window_handles.last
        page.driver.browser.switch_to.window(result)
        sleep 1
      end

    def preencher_dados_compra
        Utils.new.mudar_aba
        assert_no_selector('.loader-container.ng-scope', wait: 15)
        cadastroData = INFO[:dados_cadastro]
        email = cadastroData[:email]
        find(ELEMENTS['text_email_contato']).set(email)
        find(ELEMENTS['text_nome']).set(cadastroData[:nome])
        find(ELEMENTS['text_sobrenome']).set(cadastroData[:sobrenome])
        sleep 1

        find(ELEMENTS['text_nascimento']).set('11/11/2000')
        within('#passengers_form') do
            find('select').select('Masculino')
        end

        find(ELEMENTS['cartao_bandeira']).select('Mastercard')
        find(ELEMENTS['cartao_numero']).set('5253489702456326')
        find(ELEMENTS['cartao_mes']).select('12')
        find(ELEMENTS['cartao_ano']).select('2024')
        find(ELEMENTS['cartao_cpf']).set(cadastroData[:cpf])
        find(ELEMENTS['cartao_cvv']).set('225')
        find(ELEMENTS['cartao_nome']).set(cadastroData[:nome])
        find(ELEMENTS['text_cep']).set('11030101')
        find(ELEMENTS['text_cep']).send_keys :tab
        sleep 1
        find(ELEMENTS['text_endereco_numero']).set('69')
        find(ELEMENTS['text_email']).set(email)
        find(ELEMENTS['text_email_confirma']).set(email)
        find(ELEMENTS['text_telefone']).set(cadastroData[:telefone])
        find(ELEMENTS['button_termos']).click
        find(ELEMENTS['button_finalizar']).click
    end

    def assertReserva
        assert_no_selector('.loader-container.ng-scope', wait: 30)
        assert_text('Reserva em processamento.')    
    end
    
end