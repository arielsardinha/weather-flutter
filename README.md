# Documentação do Projeto: Desenvolvedor Flutter Pleno

## Observações
Notei que vocês dão grande ênfase ao BloC. Por isso, desenvolvi o projeto com e sem o uso do pacote, os quais estão em branches distintas.

Com o pacote: flutter_bloc -> [Link para o branch main](https://github.com/arielsardinha/weather-flutter/tree/main)

Sem o pacote: padrão de projeto BloC -> [Link para o branch developer](https://github.com/arielsardinha/weather-flutter/tree/developer)


## Índice

- [Descrição do Projeto](#descrição-do-projeto)
- [Funcionalidades Implementadas](#funcionalidades-implementadas)
- [Tecnologias e Ferramentas](#tecnologias-e-ferramentas)
- [Como Executar o Projeto](#como-executar-o-projeto)

## Descrição do Projeto

Este projeto é um aplicativo que utiliza a API gratuita do OpenWeatherMap para exibir informações meteorológicas sobre a localização atual do usuário.

## Funcionalidades Implementadas

1. **Tela de previsão do tempo.**
   - A tela principal exibe a temperatura atual, a descrição do clima, a umidade e a velocidade do vento da localização atual do usuário.
   - A tela tem um botão para atualizar as informações.
   - A tela tem opção de pesquisar o clima de alguma região
   - A tela mostra a previsão do tempo dos próximos 5 dias para a localização atual do usuário.
2. **Tela de configurações.**
   - É possível acessar uma tela de configurações a partir da tela principal.
   - A tela de configurações permite que o usuário selecione as unidades de temperatura (Celsius, Fahrenheit e Kelvin) e a língua da descrição do clima.

## Tecnologias e Ferramentas

- Flutter BLoC para gerenciamento do estado do aplicativo, com e sem package.
- Princípios de design orientado a objetos, Clean Architecture e SOLID foram seguidos para a estruturação do projeto, além de alguns design patterns como, factory methods, repository, DTO e BloC.
- A API gratuita do OpenWeatherMap foi utilizada para obter as informações meteorológicas.
- Utilizado Flutter SDK mais recente disponível.
- Controle de dependências realizado com o gerenciador de pacotes Flutter, o Pub.
- Versionamento do código feito utilizando Git.

## Como Executar o Projeto

Para executar este projeto Flutter no ambiente local, siga os seguintes passos:

1. **Clone o repositório**

    No terminal, navegue até o diretório onde deseja clonar o repositório e execute o seguinte comando:

    ```bash
    git clone https://github.com/arielsardinha/weather-flutter.git
    ```

2. **Instale as dependências do Flutter**

    Navegue até o diretório do projeto clonado e execute o seguinte comando para instalar todas as dependências necessárias listadas no arquivo `pubspec.yaml`:

    ```bash
    cd your-repository
    flutter pub get
    ```

3. **Execute o aplicativo**

    Agora você pode executar o aplicativo no seu emulador ou dispositivo físico usando o seguinte comando:

    ```bash
    flutter run
    ```

    Isso irá iniciar o aplicativo Flutter no seu dispositivo.

