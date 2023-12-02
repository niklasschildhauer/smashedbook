import { Container, CosmosClient, Database, FeedResponse, Item, ItemResponse } from "@azure/cosmos";
import { RecipeDatabase } from "./RecipeDatabase";
import { HttpError } from "../model/HttpError";

// TODO: implement error handling
export class RecipeDatabaseCosmosDB implements RecipeDatabase {

    constructor(private cosmosDB: CosmosDB = new CosmosDB()) {
    }

    async save(recipe: Recipe): Promise<void> {
        const { statusCode } = await this.getRecipeByIdFromCosmosDB(recipe.id)

        if (statusCode === 404) {
            await this.createRecipeInCosmosDB(recipe)
        } else {
            await this.updateRecipeByIdInCosmosDB(recipe)
        }
    }

    async get(id: string): Promise<Recipe> {
        console.log("Get" + id)
        const {resource: recipe, statusCode} = await this.getRecipeByIdFromCosmosDB(id)

        if (statusCode === 404) {
            throw new HttpError(404, "Recipe not found");
        }

        return recipe;
    }

    private async getRecipesByIdFromCosmosDB(id: string): Promise<FeedResponse<Recipe>> {
        const container = await this.cosmosDB.getContainer()
        const items = await container.items.query({
            query: "SELECT * FROM Recipes r WHERE r.id = @recipeId",
            parameters: [
                {
                    name: "@recipeId",
                    value: id
                }
            ]
        }).fetchAll()

        return items
    }

    private async getRecipeByIdFromCosmosDB(id: string): Promise<ItemResponse<Recipe>> {
        const container = await this.cosmosDB.getContainer()
        return await container.item(id).read();
    }

    private async updateRecipeByIdInCosmosDB(recipe: Recipe): Promise<ItemResponse<Recipe>> {
        const container = await this.cosmosDB.getContainer()
        return await container.item(recipe.id).replace(recipe);
    }

    private async createRecipeInCosmosDB(recipe: Recipe): Promise<ItemResponse<Recipe>> {
        const container = await this.cosmosDB.getContainer()
        return await container.items.create(recipe);
    }

}

class CosmosDB {
    private cosmosClient?: CosmosClient
    private database?: Database
    private container?: Container
    
    constructor(
        private connectionString: string = process.env.CosmosDbConnectionString,
        private databaseName: string = 'MealPlanDatabase',
        private containerName: string = 'Recipes'
        ) {}

    getContainer(): Promise<Container> {
        if (this.container) {
            return Promise.resolve(this.container);
        }

        return this.createIfNotExists();
    }

    private async createIfNotExists(): Promise<Container> {
        this.cosmosClient = new CosmosClient(this.connectionString);
        const { database } = await this.cosmosClient.databases.createIfNotExists({ id: this.databaseName });
        this.database = database;
        const { container } = await this.database.containers.createIfNotExists({ id: this.containerName });
        this.container = container;
        return this.container;
    }
}
