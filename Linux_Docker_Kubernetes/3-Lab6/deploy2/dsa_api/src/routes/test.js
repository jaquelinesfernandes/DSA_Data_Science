// Constantes
const express = require('express');
const router = express.Router();

// Método get
router.get('/', async (req, res) => {
	res.status(200).json({
		result: 'Sucesso! A API funciona!'
	})
});

// Export
module.exports = router;