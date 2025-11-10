*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.amazon.com.br/
${MENU_ELETRONICOS}      //a[contains(text(),'Eletrônicos')]
${TEXTO_HEADER_LETRONICOS}    Eletrônicos e Tecnologia
${HEADER_ELETRONICOS}    (//span[contains(text(),'Eletrônicos e Tecnologia')])[1]
${CAMPO_PESQUISA}                //input[@id='twotabsearchtextbox'] 
${BOTAO_PESQUISA}                (//input[@id='nav-search-submit-button'])[1]
${BOTAO_ADICIONAR_CARRINHO}      //input[@id='add-to-cart-button']



*** Keywords ***

Abrir o navegador
    Open Browser    ${URL}    chrome    executable_path=/usr/bin/chromedriver
    Maximize Browser Window
    Set Selenium Implicit Wait    10s

Fechar o navegador    
    Capture Page Screenshot
    Close Browser    


Acessar a home page do site Amazon.com.br
    Go To  url=${URL}
    Wait Until Element Is Visible     locator=${MENU_ELETRONICOS}


Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS} 


Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}



 Verificar se o titulo da pagina "${TITULO}" 
    Title Should Be  title=${TITULO}


Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=(//img[@class='a-dynamic-image dcl-dynamic-image'])[20]



# Caso de testes 2



Digitar o nome de produto "${PRODUTO} no campo de pesquisa
    Input Text    locator=(//input[@id='twotabsearchtextbox'])[1]   text=${PRODUTO}
    
        
Clicar no botão de pesquisa   
    Click Element    locator=nav-search-submit-button


Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=//span[normalize-space()='${PRODUTO}']



# caso de testes 3 

Adicionar o produto "${PRODUTO}" no carrinho
    Click Element    locator=//span[normalize-space()='Console Xbox Series S']
    Wait Until Element Is Visible    locator=//input[@id='add-to-cart-button']
    Click Button    locator=//input[@id='add-to-cart-button']
    Wait Until Element Is Visible    locator=//input[@aria-labelledby='attachSiNoCoverage-announce']
    Click Button    locator=//input[@aria-labelledby='attachSiNoCoverage-announce']


Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Wait Until Element Is Visible    locator=//h1[normalize-space()='Adicionado ao carrinho']    timeout=10s

# caso de teste 4

Remover o produto "Console Xbox Series S" do carrinho
    Wait Until Element Is Visible    locator=Wait Until Element Contains    locator=(//span[@class='a-icon a-icon-small-trash'])[1]
    Click Element   locator=(//span[@class='a-icon a-icon-small-trash'])[1]
    

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//span[normalize-space()='foi removido de Carrinho de compras.']    timeout=10s




#GHERKIN STEPS
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o titulo da pagina "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"   
    Entrar no menu "Eletrônicos" 
    

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"   
    Verificar se aparece a frase "Eletrônicos e Tecnologia"
    

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se o titulo da pagina "Eletrônicos e Tecnologia | Amazon.com.br" 


E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"



#Teste 2

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa


Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o titulo da pagina "Amazon.com.br : Xbox Series S\""
    
    


E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "PRODUTO"
    

#Teste 3 


Dado que o usuário acessa a home page do site Amazon.com.br
     Acessar a home page do site Amazon.com.br
    Verificar se o titulo da pagina "Amazon.com.br | Tudo pra você, de A a Z."

Quando ele digita o nome do produto "${produto}" no campo de pesquisa
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

E clica no botão de pesquisa
    Click Element    locator=nav-search-submit-button

Então o resultado da pesquisa deve listar o produto "${produto}"
    Verificar se o titulo da pagina "Amazon.com.br : xbox series s"

Quando ele adiciona o produto "${produto}" ao carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho
    # Click Element    locator=//span[normalize-space()='Console Xbox Series S']
    # Click Element    ${BOTAO_ADICIONAR_CARRINHO}
    # Wait Until Element Is Visible    locator=//input[@aria-labelledby='attachSiNoCoverage-announce']
    # Click Button    locator=//input[@aria-labelledby='attachSiNoCoverage-announce']

Então o produto "${produto}" deve ser adicionado com sucesso
    Wait Until Page Contains    ${produto}
    Page Should Contain         ${produto}
   


# Caso de Teste 04 

E existe o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho


 Quando remover o produto "Console Xbox Series S" do carrinho
     Remover o produto "Console Xbox Series S" do carrinho



Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio    