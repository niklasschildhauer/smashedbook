const express = require('express');
const bodyParser = require('body-parser');
const mockRecipes = require('./recipesMock.json');
const mockRecipeDetail = require('./recipeDetail.json');

const app = express();
const port = 3000; // You can choose any available port

// Middleware to parse JSON requests
app.use(bodyParser.json());

// Sample data to store recipes (replace with a database in a proper implementation)
const recipes = mockRecipes;
const recipeDetail = mockRecipeDetail;

// GET route to fetch all recipes
app.get('/recipes', (req, res) => {
  // wait for 1 second before sending the response
  setTimeout(() => res.json(recipes), 1000);
});

app.get('/recipe/:id/detail', (req, res) => {
    // wait for 1 second before sending the response
    setTimeout(() => res.json(recipeDetail), 1000);
});

// POST route to add a new recipe
app.post('/recipe', (req, res) => {
  const newRecipe = req.body;
  recipes.push(newRecipe);
  res.status(201).json(newRecipe);
});

// PUT route to update a recipe by ID
app.put('/recipe/:id', (req, res) => {
  const recipeId = req.params.id;
  const updatedRecipe = req.body;
  const index = recipes.findIndex(recipe => recipe.id === recipeId);
  console.log("We are on it")

  if (index !== -1) {
    recipes[index] = updatedRecipe;
    res.json(updatedRecipe);
    console.log(mockRecipes)
  } else {
    res.status(404).json({ message: 'Recipe not found' });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});