# Tema: 
Aplicativo de Gamificação do Processo Sustentável.
# Sobre
O projeto tem como objetivo promover e disseminar o conhecimento acerca dos Objetivos de Desenvolvimento Sustentável da ONU. Para isso,
foi criado um aplicativo que, diariamente, proporciona diferentes desafios sobre atividades sustentáveis (dentro dos temas e objetivos elencados pela ONU).
# Integrantes:

  <ul>260545, João Yukio Takaki</ul>
  <ul>260551, José Eduardo Santos Rabelo</ul>
  <ul>246125, Lucas Cardoso</ul>
  <ul>260660, Rafael De Almeida Casonato</ul>
  <ul>247277, Matheus Hencklein Ponte</ul>

# Prototipação:
[Figma](https://www.figma.com/design/tAOCrY6VNnqSlHbewg3db4/Untitled?node-id=25-24&t=vmKW9GMzskKzTwA8-1)

# Repositório: 
[GitHub](https://github.com/Joaotakaki1/mc656-final-project)

# Arquitetura do Projeto
## Diagrama de componentes (Modelo C4)
[Imagem](Caminho/para/imagem/)

## Estilo de arquitetura
Escolhemos o estilo de arquitetura Objetos. Esse estilo combina dados e funções em uma única entidade, o objeto, visando decompor o problema, facilitar sua manutenção e o reuso. Pareceu-nos mais adequado utilizar esse estilo pois, dessa forma, modularizamos o nosso código para que cada classe realize uma porção da tarefa, como o login e autenticação de um usuário, cadastro de novo usuário, armazenamento e leitura de seus dados de um banco de dados, entre outras funções imprescindíveis ao funcionamento de nosso aplicativo.

## Descrição dos componentes
### Controlador de Login:
Responsável pela autenticação de um usuário, conferindo o nome de usuário e a senha dados, para que o utilizador possa acessar sua conta, seus desafios e seu progresso.
### Controlador de Cadastro:
Responsável por inserir um novo usuário no banco de dados da aplicação, também verificando se aquele nome de usuário está disponível ou não para o uso, de forma que cada username é único.
### Controlador de Gamificação: 
Responsável por acompanhar o progresso do usuário nos desafios, fornecer conquistas quando os desafios são completados e, também, gerar gráficos com o impacto ambiental causado pelo usuário ao cumpri-los.
### Controlador de Preferência do Usuário:
Responsável por acessar o controlador de armazenamento com o objetivo de modificar as preferências do usuário, atualizando-as ou inicializando-as. Este controlador garante uma experiência personalizada, permitindo que as configurações individuais sejam mantidas e aplicadas de forma consistente em cada interação do usuário com o aplicativo.
### Controlador de Desafios:
Responsável por gerar desafios de acordo com as preferências de cada usuário e utiliza dos desafios completos para atualizar o progresso do usuário. Esse controlador contribui para a gamificação do aplicativo, incentivando o usuário a completar os desafios e permitindo um acompanhamento detalhado do seu progresso.
### Controlador de Armazenamento de Usuário:
Responsável por acessar o banco de dados com intuito de extrair, inserir e modificar informações de acordo com as necessidades de cada controlador. Ele atua como intermediário entre a camada de dados e os demais componentes do sistema, garantindo que todas as operações de armazenamento sejam realizadas de maneira eficiente e segura.

## Padrão de projeto
Este projeto utiliza o padrão de projeto Facade para simplificar a interface entre o aplicativo móvel e diversos componentes, como login, cadastro, desafios e preferências do usuário. A implementação do Facade centraliza essas operações em uma única classe, chamada AppFacade, que oferece uma interface fácil de usar para o código principal do aplicativo, promovendo uma arquitetura mais organizada e de fácil manutenção.

O uso do Facade traz vários benefícios ao projeto: centraliza as funcionalidades principais (como login, cadastro, obtenção de desafios e atualização de preferências), reduz o acoplamento entre o código da interface do usuário e os controladores específicos e as alterações nos controladores não afetam diretamente o código que usa o Facade. Esse padrão também contribui para a escalabilidade: novos serviços e controladores podem ser adicionados ao projeto sem impactar o código principal, bastando atualizar a AppFacade para integrar novas funcionalidades de maneira consistente e simplificada.

A adoção do padrão Facade neste projeto facilita o desenvolvimento, a manutenção e a escalabilidade do código, criando uma interface simplificada e unificada para interagir com diversas funcionalidades complexas.

