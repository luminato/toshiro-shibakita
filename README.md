# Linux Experience
## Atividade final do projeto na DIO

[Denilson Bonatti]: https://github.com/denilsonbonatti
[installdocker.sh]: https://github.com/luminato/toshiro-shibakita/
[docker_containers_create.sh]: https://github.com/luminato/toshiro-shibakita/


> Docker: Utilização prática no cenário de Microsserviços 
> Instrutor: [Denilson Bonatti] 
> Digital Innovation One

### Pré-requisitos: 
- Conhecimentos básicos em Linux, Docker e AWS.

### Apresentação

Muito se tem falado de containers e consequentemente do Docker no ambiente de desenvolvimento. Mas qual a real função de um container no cenários de microsserviços? Qual a real função e quais exemplos práticos podem ser aplicados no dia a dia? Essas são algumas das questões que serão abordadas de forma prática pelo Expert Instructor Denilson Bonatti nesta Live Coding. IMPORTANTE: Agora nossas Live Codings acontecerão no canal oficial da dio._ no YouTube. Então, já corre lá e ative o lembrete!
    
## Instalação e configurações iniciais

Será instalado o docker nos servidores

- baixe e execute o arquivo [installdocker.sh] para uma instação mais rápida

```sh
#chmod +x installdocker.sh
#./installdocker.sh
```
- baixe e execute o arquivo [docker_containers_create.sh] para uma instação mais rápida

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

## Iniciando o swarm
+ no servidor onde o banco foi configurado deverá rodar o comando:
```sh
#docker swarm init
```

+ nos demais servidores (o docker deverá está instalado)

copiar o arquivo gerado com o token e ip
```sh
exempo: docker swarm join --token SWMTKN-1-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 172.xx.xx.xxx:2377
```




## Replicando o servidor

para listar os servidores conectado no servidor principal:
```sh
#docker node ls
```

#### Configurações do servidor principal

execute o comando para replicar o servidor 
```sh
#docker service create --name web-server --replicas 10 -dt -p 80:80 --mount type=volume,src=app,dst=/app/ webdevops/php-apache:alpine-php7
```

adicionando o as configurações do servidor principal que sera compartilhado:
```sh
#apt install nfs-server
```
acessar o arquivo */etc/exports* e adicione o caminho abaixo na ultima linha
```sh
#nano /etc/exports
/var/lib/docker/volumes/app/_data *(rw,sync,subtree_check)
```

realizar o export para compartilhar o arquivo informado
```sh
#exportfs -ar
```

#### Configurações dos servidores cliente

adicionando o as configurações nos servidores cliente:
```sh
#apt install nfs-common
```

montar o arquivo compartilhado no servidor do cliente
```sh
#mount -o v3 172.xx.xx.xxx:/var/lib/docker/volumes/app/_data /var/lib/docker/volumes/app/_data
```

## Configurando proxy com o NGINX

criar um pasta na raiz do projeto chamada proxy
```sh
#mkdir /proxy
```

Criar os arquivos:
- dockerfile
- nginx.conf

com as configurações de ip do servidor e do cliente

executar o comando para criar uma nova imagem:
```sh
#docker build -t proxy-app .
```

subir a imagem criada:
```sh
#docker run --name my-poxy-app -dti -p 4500:4500 proxy-app
```

## Informações
[Fabricio Luminato]: https://www.linkedin.com/in/fabricioluminato


Projeto realizado e documentado por [Fabricio Luminato]
