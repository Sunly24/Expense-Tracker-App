const { db } = require('../database/db');

exports.createUser = (email, username, hashedPass) => {
  return new Promise((resolve, reject) => {
    const sql = `INSERT INTO USERS (EMAIL, USERNAME, HASHED_PASS) VALUES (?, ?, ?)`;
    db.run(sql, [email, username, hashedPass], function(err) {
      if (err) reject(err);
      else resolve(this.lastID);
    });
  });
};

exports.findUserByEmail = (email) => {
  return new Promise((resolve, reject) => {
    const sql = `SELECT * FROM USERS WHERE EMAIL = ?`;
    db.get(sql, [email], (err, row) => {
      if (err) reject(err);
      else resolve(row);
    });
  });
};
