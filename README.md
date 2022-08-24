# Linux Experience
## Atividade final do projeto na DIO

[Denilson Bonatti]: https://github.com/denilsonbonatti

Docker: Utilização prática no cenário de Microsserviços 
Instrutor: [Denilson Bonatti] 
Digital Innovation One

### Pré-requisitos: 
- Conhecimentos básicos em Linux, Docker e AWS.

### Apresentação

Muito se tem falado de containers e consequentemente do Docker no ambiente de desenvolvimento. Mas qual a real função de um container no cenários de microsserviços? Qual a real função e quais exemplos práticos podem ser aplicados no dia a dia? Essas são algumas das questões que serão abordadas de forma prática pelo Expert Instructor Denilson Bonatti nesta Live Coding. IMPORTANTE: Agora nossas Live Codings acontecerão no canal oficial da dio._ no YouTube. Então, já corre lá e ative o lembrete!
    
## Instalação e configurações iniciais

Será instalado o docker nos servidores

- baixe e execute o arquivo installdocker.sh para uma instação mais rápida

```sh
#chmod +x installdocker.sh
#./installdocker.sh
```
- baixe e execute o arquivo docker_containers_create.sh para uma instação mais rápida

#### !!! ativar acesso a porta 3306 do mysql nas regras de entrada ec2

Criando os volumes manual no docker

```sh
#docker volume create app
#docker volume create data
#docker run -e MYSQL_ROOT_PASSWORD=Senha123 -e MYSQL_DATABASE=meubanco --name mysql-A -d -p 3306:3306 --mount type=volume,src=data,dst=/var/lib/mysql/ mysql:5.7
```

Criando um serviço manual php
```sh
#cd /var/lib/docker/volumes/app/_data
#nano index.php
#docker run --name web-server -dt -p 80:80 --mount type=volume,src=app,dst=/app/ webdevops/php-apache:alpine-php7
```

## Estressando o servidor

- Acesse o loader.io 
- Realize as configurações para acesso
- Crie um novo teste para verificar a resposta do serviço
