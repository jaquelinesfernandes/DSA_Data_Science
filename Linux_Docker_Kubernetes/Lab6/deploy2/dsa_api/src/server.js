// Constantes
const http = require('http');
const express = require('express');
const bodyParser = require('body-parser');
const loggingService = require('./services/loggingService')
const NAMESPACE = 'server';

// Cria a app
const app = express();

// Registra a request
app.use((req, res, next) => {
	loggingService.info(NAMESPACE, `METHOD - [${req.method}], URL - [${req.url}], IP - [${req.socket.remoteAddress}]`);

	res.on('finish', () => {
		loggingService.info(NAMESPACE, `METHOD - [${req.method}], URL - [${req.url}], IP - [${req.socket.remoteAddress}], STATUS - [${res.statusCode}]`);
	});
	next();
});

// Parse requests 
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json({limit: '50mb'}));

// Regras da API
app.use((req, res, next) => {
	res.header('Access-Control-Allow-Origin', '*');
	res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
	if (req.method == 'OPTIONS') {
		res.header('Access-Control-Allow-Headers', 'GET PATCH DELETE POST PUT')
		return res.status(200).json({});
	}
	next();
})

// Rotas
app.use('/api/test', require('./routes/test'));

// Tratamento de erro
app.use((req, res, next) => {
	const error = new Error('not found');
	return res.status(404).json({
		message: error.message
	});
})

// Cria o servidor
const httpServer = http.createServer(app);
const PORT = process.env.PORT || 5000;
httpServer.listen(PORT, () => {
	loggingService.info(NAMESPACE, `Servidor executando na porta ${PORT}`)
})

