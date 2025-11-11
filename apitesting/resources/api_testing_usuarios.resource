*** Settings ***
Library    RequestsLibrary
Library    String


*** Keywords ***

Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}  ${palavra_aleatoria}@emailteste.com
    Log    ${EMAIL_TESTE}   