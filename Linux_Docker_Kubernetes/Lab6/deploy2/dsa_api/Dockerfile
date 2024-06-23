# Imagem base
FROM node:19-alpine

# Cria a pasta da app
RUN mkdir -p /usr/src/app

# Define a pasta de trabalho
WORKDIR /usr/src/app

# Copia o arquivo de dependências
COPY src/package.json .

# Instala as dependências
RUN npm install

# Copia os arquivos da app
COPY . .

# Exports
EXPOSE 80
CMD [ "npm", "run", "dev" ]
