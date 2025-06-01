const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Banco de dados SQLite
const db = new sqlite3.Database('./banco_digital.db');

// Criar tabela de contas (se não existir)
db.run(`CREATE TABLE IF NOT EXISTS contas (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT,
  email TEXT UNIQUE,
  senha TEXT,
  saldo REAL DEFAULT 0
)`);

// Rota para cadastro de conta
app.post('/cadastro', (req, res) => {
  const { nome, email, senha } = req.body;
  if (!nome || !email || !senha) {
    return res.status(400).json({ error: 'Campos obrigatórios faltando.' });
  }

  // Inserir no banco
  const query = `INSERT INTO contas (nome, email, senha, saldo) VALUES (?, ?, ?, 0)`;
  db.run(query, [nome, email, senha], function(err) {
    if (err) {
      return res.status(500).json({ error: 'Erro ao criar conta. Talvez o email já exista.' });
    }
    res.status(201).json({ message: 'Conta criada com sucesso', id: this.lastID });
  });
});

// Rota para login (exemplo simples, sem token)
app.post('/login', (req, res) => {
  const { email, senha } = req.body;
  if (!email || !senha) {
    return res.status(400).json({ error: 'Email e senha são obrigatórios' });
  }

  db.get(`SELECT * FROM contas WHERE email = ? AND senha = ?`, [email, senha], (err, row) => {
    if (err) return res.status(500).json({ error: 'Erro no servidor' });
    if (!row) return res.status(401).json({ error: 'Usuário ou senha inválidos' });
    res.json({ id: row.id, nome: row.nome, email: row.email, saldo: row.saldo });
  });
});

// Porta do servidor
app.listen(3000, () => {
  console.log('Backend rodando na porta 3000');
});


