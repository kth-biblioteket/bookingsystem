# KTH Bibliotekets bokningssystem för diverse tjänster
- Grupprum
- Lässtudio
- Handledning
- Talbok
- Cas
- Öppettider

## Funktioner
Startas i en Dockercontainer

###
Deploy via github actions som anropar en webhook

#### Dependencies
php:7.3-apache
libxml2-dev
locales en_GB.UTF-8
docker-php-ext-install mysqli pdo pdo_mysql php7.3-soap


##### Installation

1.  Skapa folder på server med namnet på repot: "/local/docker/bookingsystem"
2.  Skapa och anpassa docker-compose.yml i foldern
```
version: "3.6"

services:
  grouprooms1:
    container_name: grouprooms1
    depends_on:
      - grouprooms-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    restart: unless-stopped
    env_file:
      - .env
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.grouprooms1.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_GROUPROOMS}`)"
      - "traefik.http.services.grouprooms1.loadbalancer.server.port=80"
      - "traefik.http.services.grouprooms1.loadbalancer.sticky=true"
      - "traefik.http.routers.grouprooms1.middlewares=grouprooms1-stripprefix"
      - "traefik.http.middlewares.grouprooms1-stripprefix.stripprefix.prefixes=${PATHPREFIX_GROUPROOMS}"
      - "traefik.http.routers.grouprooms1.entrypoints=websecure"
      - "traefik.http.routers.grouprooms1.tls=true"
      - "traefik.http.routers.grouprooms1.tls.certresolver=myresolver"
    volumes:
      - /local/docker/bookingsystem/config_grouprooms.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_grouprooms.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"

  grouprooms2:
    container_name: grouprooms2
    depends_on:
      - grouprooms-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    env_file:
      - .env
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.grouprooms2.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_GROUPROOMS}`)"
      - "traefik.http.services.grouprooms2.loadbalancer.server.port=80"
      - "traefik.http.services.grouprooms2.loadbalancer.sticky=true"
      - "traefik.http.routers.grouprooms2.middlewares=grouprooms2-stripprefix"
      - "traefik.http.middlewares.grouprooms2-stripprefix.stripprefix.prefixes=${PATHPREFIX_GROUPROOMS}"
      - "traefik.http.routers.grouprooms2.entrypoints=websecure"
      - "traefik.http.routers.grouprooms2.tls=true"
      - "traefik.http.routers.grouprooms2.tls.certresolver=myresolver"
    restart: unless-stopped
    volumes:
      - /local/docker/bookingsystem/config_grouprooms.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_grouprooms.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"

  grouproomskiosk1:
    container_name: grouproomskiosk1
    depends_on:
      - grouprooms-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.grouproomskiosk1.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_GROUPROOMS_KIOSK}`)"
      - "traefik.http.routers.grouproomskiosk1.middlewares=grouproomskiosk1-stripprefix"
      - "traefik.http.middlewares.grouproomskiosk1-stripprefix.stripprefix.prefixes=${PATHPREFIX_GROUPROOMS_KIOSK}"
      - "traefik.http.routers.grouproomskiosk1.entrypoints=websecure"
      - "traefik.http.routers.grouproomskiosk1.tls=true"
      - "traefik.http.routers.grouproomskiosk1.tls.certresolver=myresolver"
    volumes:
      - /local/docker/bookingsystem/config_grouprooms_kiosk.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_grouprooms_kiosk.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"

  grouprooms-db:
    container_name: grouprooms-db
    image: mysql:8.0
    restart: unless-stopped
    env_file:
      - .env
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
    volumes:
      - persistent-grouprooms-db:/var/lib/mysql
      - ./dbinit_grouprooms:/docker-entrypoint-initdb.d
    networks:
      - "apps-net"

  readingstudios:
    container_name: readingstudios
    depends_on:
      - readingstudios-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.readingstudios.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_READINGSTUDIOS}`)"
      - "traefik.http.routers.readingstudios.middlewares=readingstudios-stripprefix"
      - "traefik.http.middlewares.readingstudios-stripprefix.stripprefix.prefixes=${PATHPREFIX_READINGSTUDIOS}"
      - "traefik.http.routers.readingstudios.entrypoints=websecure"
      - "traefik.http.routers.readingstudios.tls=true"
      - "traefik.http.routers.readingstudios.tls.certresolver=myresolver"
    volumes:
      - /local/docker/bookingsystem/config_readingstudios.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_readingstudios.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"
  
  readingstudioskiosk:
    container_name: readingstudioskiosk
    depends_on:
      - readingstudios-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.readingstudioskiosk.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_READINGSTUDIOS_KIOSK}`)"
      - "traefik.http.routers.readingstudioskiosk.middlewares=readingstudioskiosk-stripprefix"
      - "traefik.http.middlewares.readingstudioskiosk-stripprefix.stripprefix.prefixes=${PATHPREFIX_READINGSTUDIOS_KIOSK}"
      - "traefik.http.routers.readingstudioskiosk.entrypoints=websecure"
      - "traefik.http.routers.readingstudioskiosk.tls=true"
      - "traefik.http.routers.readingstudioskiosk.tls.certresolver=myresolver"
    volumes:
      - /local/docker/bookingsystem/config_readingstudios_kiosk.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_readingstudios_kiosk.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"

  readingstudios-db:
    container_name: readingstudios-db
    image: mysql:8.0
    restart: unless-stopped
    env_file:
      - .env
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
    volumes:
      - persistent-readingstudios-db:/var/lib/mysql
      - ./dbinit_readingstudios:/docker-entrypoint-initdb.d
    networks:
      - "apps-net"

  handledning:
    container_name: handledning
    depends_on:
      - handledning-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.handledning.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_HANDLEDNING}`)"
      - "traefik.http.routers.handledning.middlewares=handledning-stripprefix"
      - "traefik.http.middlewares.handledning-stripprefix.stripprefix.prefixes=${PATHPREFIX_HANDLEDNING}"
      - "traefik.http.routers.handledning.entrypoints=websecure"
      - "traefik.http.routers.handledning.tls=true"
      - "traefik.http.routers.handledning.tls.certresolver=myresolver"
    volumes:
      - /local/docker/bookingsystem/config_handledning.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_handledning.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"

  handledning-db:
    container_name: handledning-db
    image: mysql:8.0
    restart: unless-stopped
    env_file:
      - .env
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
    volumes:
      - persistent-handledning-db:/var/lib/mysql
      - ./dbinit_handledning:/docker-entrypoint-initdb.d
    networks:
      - "apps-net"

  talbok:
    container_name: talbok
    depends_on:
      - talbok-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.talbok.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_TALBOK}`)"
      - "traefik.http.routers.talbok.middlewares=talbok-stripprefix"
      - "traefik.http.middlewares.talbok-stripprefix.stripprefix.prefixes=${PATHPREFIX_TALBOK}"
      - "traefik.http.routers.talbok.entrypoints=websecure"
      - "traefik.http.routers.talbok.tls=true"
      - "traefik.http.routers.talbok.tls.certresolver=myresolver"
    volumes:
      - /local/docker/bookingsystem/config_talbok.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_talbok.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"

  talbok-db:
    container_name: talbok-db
    image: mysql:8.0
    restart: unless-stopped
    env_file:
      - .env
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
    volumes:
      - persistent-talbok-db:/var/lib/mysql
      - ./dbinit_talbok:/docker-entrypoint-initdb.d
    networks:
      - "apps-net"

  cas:
    container_name: cas
    depends_on:
      - cas-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.cas.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_CAS}`)"
      - "traefik.http.routers.cas.middlewares=cas-stripprefix"
      - "traefik.http.middlewares.cas-stripprefix.stripprefix.prefixes=${PATHPREFIX_CAS}"
      - "traefik.http.routers.cas.entrypoints=websecure"
      - "traefik.http.routers.cas.tls=true"
      - "traefik.http.routers.cas.tls.certresolver=myresolver"
    volumes:
      - /local/docker/bookingsystem/config_cas.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_cas.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"

  cas-db:
    container_name: cas-db
    image: mysql:8.0
    restart: unless-stopped
    env_file:
      - .env
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
    volumes:
      - persistent-cas-db:/var/lib/mysql
      - ./dbinit_cas:/docker-entrypoint-initdb.d
    networks:
      - "apps-net"

  openinghours:
    container_name: openinghours
    depends_on:
      - openinghours-db
    image: ghcr.io/kth-biblioteket/bookingsystem:${REPO_TYPE}
    restart: unless-stopped
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.openinghours.rule=Host(`${DOMAIN_NAME}`) && PathPrefix(`${PATHPREFIX_OPENINGHOURS}`)"
      - "traefik.http.routers.openinghours.middlewares=openinghours-stripprefix"
      - "traefik.http.middlewares.openinghours-stripprefix.stripprefix.prefixes=${PATHPREFIX_OPENINGHOURS}"
      - "traefik.http.routers.openinghours.entrypoints=websecure"
      - "traefik.http.routers.openinghours.tls=true"
      - "traefik.http.routers.openinghours.tls.certresolver=myresolver"
    volumes:
      - /local/docker/bookingsystem/config_openinghours.inc.php:/var/www/html/config.inc.php
      - /local/docker/bookingsystem/custom_openinghours.css:/var/www/html/css/custom.css
    networks:
      - "apps-net"

  openinghours-db:
    container_name: openinghours-db
    image: mysql:8.0
    restart: unless-stopped
    env_file:
      - .env
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
    volumes:
      - persistent-openinghours-db:/var/lib/mysql
      - ./dbinit_openinghours:/docker-entrypoint-initdb.d
    networks:
      - "apps-net"

volumes:
  persistent-grouprooms-db:
  persistent-readingstudios-db:
  persistent-handledning-db:
  persistent-talbok-db:
  persistent-cas-db:
  persistent-openinghours-db:

networks:
  apps-net:
    external: true

```
3.  Skapa och anpassa .env(för composefilen) i foldern
```
DB_DATABASE=bookingsystem
DB_USER=bookingsystem
DB_PASSWORD=xxxxxx
DB_ROOT_PASSWORD=xxxxxx
PATHPREFIX_GROUPROOMS=/mrbsgrupprum
PATHPREFIX_GROUPROOMS_KIOSK=/mrbsgrupprumkiosk
PATHPREFIX_READINGSTUDIOS=/mrbsreadingstudios
PATHPREFIX_READINGSTUDIOS_KIOSK=/mrbsreadingstudioskiosk
PATHPREFIX_HANDLEDNING=/mrbshandledning
PATHPREFIX_TALBOK=/mrbstalbok
PATHPREFIX_CAS=/mrbscas
PATHPREFIX_OPENINGHOURS=/mrbsopeninghours
DOMAIN_NAME=apps-ref.lib.kth.se
REPO_TYPE=ref
```

4.  Skapa folder "local/docker/bookingsystem"
6.  Skapa folder "local/docker/bookingsystem/dbinit"
7. Skapa init.sql från repots dbinit/init.sql
8. Skapa deploy_ref.yml i github actions
9. Skapa deploy_prod.yml i github actions
10. Github Actions bygger en dockerimage i github packages
11. Starta applikationen med docker compose up -d --build i "local/docker/bookingsystem



## Starta om enskild tjänst
- docker-compose restart [tjänstnamn]
    - ex: docker compose restart grouproomskiosk1   

