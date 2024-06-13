# Imagem base
FROM nginx:1.23-alpine

# Remove o arquivo padrão de configurações do web server
RUN rm /etc/nginx/conf.d/*

# Copia o arquivo com as nossas configurações
COPY ./conf/nginx.conf /etc/nginx/conf.d/
