const express = require('express');
const bodyParser = require('body-parser');
const mockRecipes = require('./recipiesMock.json');

const app = express();
const port = 3000; // You can choose any available port

// Middleware to parse JSON requests
app.use(bodyParser.json());

// Sample data to store recipes (replace with a database in a proper implementation)
const recipes = mockRecipes;

// GET route to fetch all recipes
app.get('/recipes', (req, res) => {
  res.json(recipes);
});

// POST route to add a new recipe
app.post('/recipes', (req, res) => {
  const newRecipe = req.body;
  recipes.push(newRecipe);
  res.status(201).json(newRecipe);
});

// PUT route to update a recipe by ID
app.put('/recipes/:id', (req, res) => {
  const recipeId = req.params.id;
  const updatedRecipe = req.body;
  const index = recipes.findIndex(recipe => recipe.id === recipeId);

  if (index !== -1) {
    recipes[index] = updatedRecipe;
    res.json(updatedRecipe);
  } else {
    res.status(404).json({ message: 'Recipe not found' });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});