const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('./banco.db', (err) => {
  if (err) return console.error('Erro ao abrir o banco:', err.message);
  console.log('Conectado ao banco SQLite');
});

module.exports = db;
