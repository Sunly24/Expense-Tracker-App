const { db } = require('../database/db');

exports.createExpense = (userId, amount, category, date, notes) => {
  return new Promise((resolve, reject) => {
    const sql = `INSERT INTO EXPENSE (USER_ID, AMOUNT, CATEGORY, DATE, NOTES) 
                 VALUES (?, ?, ?, ?, ?)`;
    db.run(sql, [userId, amount, category, date, notes || ''], function(err) {
      if (err) reject(err);
      else resolve(this.lastID);
    });
  });
};

exports.listExpenses = (userId) => {
  return new Promise((resolve, reject) => {
    const sql = `SELECT * FROM EXPENSE WHERE USER_ID = ? ORDER BY DATE DESC`;
    db.all(sql, [userId], (err, rows) => {
      if (err) reject(err);
      else resolve(rows);
    });
  });
};
