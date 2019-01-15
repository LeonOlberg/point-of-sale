[![CircleCI](https://circleci.com/gh/LeonOlberg/point-of-sale/tree/master.svg?style=svg)](https://circleci.com/gh/LeonOlberg/point-of-sale/tree/master)

Point Of Sale
=============

Sistema para armazenar, consultar e buscar pontos de venda baseados em latitude e longitude

### Do começo
A aplicação é baseada nas seguintes técnologias:
 * Ruby
 * PostgreSql
 * Docker
 * Docker-compose
 * [GEOS](https://trac.osgeo.org/geos/)

### Arquitetura e Design
Esse projeto foi criado utilizando boas praticas de código e arquitetura de sistemas, principalmente baseadas no [Domain-Driven Design](https://dzone.com/refcardz/getting-started-domain-driven?chapter=1), como por exemplo:
  * Entities
  * Application Layer
  * Repositories
  * Domain Services
  * Infrastructure gateways
  * Etc...

![dddlayered.png](https://i0.wp.com/www.ajlopez.com/images/articles/dddlayered.png)

Como é utilizado o Rails é interessante que haja um desacoplamento de algumas camadas para mantermos as boas práticas de SOLID, como é o exemplo da adoção de [applications services](https://martinfowler.com/eaaCatalog/serviceLayer.html) (no projeto chamada de [use cases](https://softwareengineering.stackexchange.com/questions/366188/ddd-are-use-cases-and-application-services-different-names-for-the-same-th)), e também de [repositórios](https://deviq.com/repository-pattern/).
Tudo isso para prolongarmos a vida útil do código e estando sempre abertos para modificações, evoluções e manutenções da aplicação.

### Site Reliability Engineering
No que tange a DevOps ou SRE, para este projeto foi criado um ambiente no [CircleCI](https://circleci.com/gh/LeonOlberg/point-of-sale) onde é feito o processo de build, com as etapas de:
  * Setup de ambiente, utilizando container docker para instanciar a aplicação
  * Instalação das dependências do projeto no container da applicação (aqui no caso as libs do GEOS)
  * Instalação e Cache das dependências ruby do projeto (Bundler)
  * Setup do container de banco de dados a parte mas na mesma rede
  * Setup do banco de dados no container já com as migrations da applicação
  * Execução de [testes](http://rspec.info/ ) de (Integração e Unitários) em toda a aplicação
  * Execução do linter com o [Style Guide](https://github.com/rubocop-hq/ruby-style-guide) definido, parte pela comunidade, parte por mim mesmo
  * Deploy da aplicação em ambiente Heroku (infelizmente essa etapa está com problemas no momento pois os dynos do Heroku tem algum problema com a instalação das libs do GEOS. De qualquer maneira, todo o ambiente, inclusive bando de dados já está configurado)

### Rodando local
Instele primeiramente o Ruby (com o bundler para gerenciar as dependencias), PostgreSql (driver apenas), Docker e o Docker-compose.
  1. Instale o [GEOS](https://github.com/rgeo/rgeo) em sua máquina
  2. Rode o Bundle Install para instalar as dependencias
  3. Rode o comando `$ docker-compose up -d`, para subir o baco de dados local
E é isso! hehe

### Rodando testes e linter
Essa aplicação está rodando com o suporte de Testes e de Code Quality Linter, para roda-los execute os seguintes comandos:
  * `rubocop -R -c .rubocop.yml`
  * `bundle exec rspec -fd`

### Executando métodos
Assim que tudo estiver OK, podemos testar as chamadas de API

#### Criando Ponto De Venda
Para cadastrar um ponto de venda, faça uma requisição POST para a rota [www.aplicação.com/ponto_de_vendas]() passando as seguintes informações: trading_name, owner_name, document, coverage_area, address.
Exemplo:

```json
  {
      "tradingName": "Adega da Cerveja - Pinheiros",
      "ownerName": "Zé da Silva",
      "document": "1432132123891/0001", //CNPJ
      "coverageArea": {
        "type": "MultiPolygon",
        "coordinates": [
          [[[30, 20], [45, 40], [10, 40], [30, 20]]],
          [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
        ]
      }, //Área de Cobertura
      "address": {
        "type": "Point",
        "coordinates": [-46.57421, -21.785741]
      }, // Localização do PDV
  }
```

#### Buscanto todos os Pontos de Venda cadastrados
Para buscar todos os pontos de venda cadastrados, apenas faça uma requisição GET na raiz.
Exemplo: [www.aplicação.com/ponto_de_vendas]()

#### Buscado um Ponto De Venda pelo ID
Para buscar um Ponto de venda específico pelo ID, faça uma requisição GET passando como query param o ID do Ponto de Venda que você quer.
Exemplo: [www.aplicação.com/ponto_de_vendas?id=9d534e45-bbdb-4b91-a452-891a9b1e1e4a]()

#### Buscando um Ponto De Venda por Latitude e Longitude
Para buscar todos os pontos de venda que atendem a uma determinada localidade basta fazer uma requisição GET passando como query params as coordenadas de latitude e longitude.
Exemplo:  [www.aplicação.com/ponto_de_vendas?lat=-46.57421&lng=-21.785741]()

### Evoluções futuras
  * Para as próximas versões da aplicação, seria interessante a adoção da biblioteca [rgeo/postgis](https://github.com/rgeo/activerecord-postgis-adapter) assim seria possível persistir as informações de geolocalização direto no banco de dados (nesse momento armazeno como uma string simples e buildo o objeto em tempo de execução).
  * Separação de informações de Coverage Area e Address de Ponto de Venda, mantendo assim um [agregado](https://martinfowler.com/bliki/DDD_Aggregate.html) e não mais uma entidade com dois atributos.
  * Consulta de pontos de venda que cobrem determinada área através de consulta no banco de dados, lazy load e não através de um `select` no array de pontos de venda (eager load), como é feito até o momento
