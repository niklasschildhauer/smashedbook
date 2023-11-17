export interface RecipeDatabase {
    save(recipe: Recipe): void;
    get(id: string): Promise<Recipe>;
}