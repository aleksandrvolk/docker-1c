FROM httpd:2.4
# Данный образ базируется на стандартном образе Debian+Apache 2.4: https://store.docker.com/images/httpd

# Копируем дистрибутив в директорию dist
COPY deb64.zip /dist/deb64.zip

# Разархивируем дистрибутив
RUN apt-get update && apt-get install -y \
    unzip && \
    unzip /dist/deb64.zip -d /dist \
     && dpkg -i /dist/*.deb \
  && rm /dist/*.deb
  
# Копируем внутрь контейнера заранее подготовленный конфиг от Apache
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Копируем внутрь контейнера заранее подготовленный конфиг с настройками подключения к серверу 1С
COPY default.vrd /usr/local/apache2/htdocs/BuhBase/default.vrd
