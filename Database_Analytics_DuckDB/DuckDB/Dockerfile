# Usaremos a imagem oficial python como base
FROM python:3.12

# Mantenedor da imagem
LABEL maintainer="DSA"

# Atualiza a lista de mirrors e instala alguns pacotes no sistema operacional
RUN apt-get update && \
    apt-get install -y wget unzip curl git sudo iputils-ping

# Define a pasta de trabalho
WORKDIR /

# Copia o arquivo de requerimentos e instala os pacotes Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Cria a pasta /dsaintro como um ponto de montagem para um volume
RUN mkdir /dsaintro
VOLUME /dsaintro

# Cria a pasta /dsaprojeto como um ponto de montagem para um volume
RUN mkdir /dsaprojeto
VOLUME /dsaprojeto

# Define o comando padrão para execução quando o container for iniciado
CMD ["/bin/bash"]

