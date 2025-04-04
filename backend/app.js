const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/authRoutes');
const expenseRoutes = require('./routes/expenseRoutes');
const { initDB } = require('./database/initDB'); // optional

const app = express();
app.use(cors());
app.use(express.json());

initDB();

// Routes
app.use('/auth', authRoutes);
app.use('/expenses', expenseRoutes);

// Start Server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

