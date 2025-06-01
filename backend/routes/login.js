const express = require('express');
const router = express.Router();
const db = require('../db');

// POST /login
router.post('/', (req, res) => {
  const { email, senha } = req.body;

  if (!email || !senha) {
    return res.status(400).json({ success: false, message: 'Email e senha são obrigatórios' });
  }

  const query = 'SELECT * FROM usuarios WHERE email = ? AND senha = ?';

  db.get(query, [email, senha], (err, row) => {
    if (err) {
      console.error('Erro ao consultar o banco:', err);
      return res.status(500).json({ success: false, message: 'Erro interno do servidor' });
    }

    if (!row) {
      return res.status(401).json({ success: false, message: 'Email ou senha incorretos' });
    }

    return res.status(200).json({ success: true, message: 'Login bem-sucedido', dados: row });
  });
});

module.exports = router;
