const { createExpense, listExpenses } = require('../models/expenseModel');

exports.addExpense = async (req, res) => {
  try {
    const userId = req.userId; // set by authMiddleware
    const { amount, category, date, notes } = req.body;
    await createExpense(userId, amount, category, date, notes);
    res.status(201).json({ message: 'Expense added successfully!' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

exports.getExpenses = async (req, res) => {
  try {
    const userId = req.userId;
    const expenses = await listExpenses(userId);
    res.json(expenses);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
