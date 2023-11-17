import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { RecipeDatabaseCosmosDB } from "../services/RecipeDatabaseCosmosDB";
import { HttpError } from "../model/HttpError";
import { log } from "console";

export async function SaveRecipe(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);
    try {
        const recipeDatabase = new RecipeDatabaseCosmosDB()

        const recipe: Recipe = await request.json() as unknown as Recipe;
        log(recipe);
        await recipeDatabase.save(recipe);
        return { status: 200 }

    } catch (error) {
        if (error instanceof HttpError) {
            return { status: error.status, body: error.message };
        } else {
            console.error(error);
            return { status: 500, body: `Internal server error` };
        }
    }
};

app.http('saveRecipe', {
    methods: ['POST'],
    route: 'recipe',
    authLevel: 'anonymous',
    handler: SaveRecipe
});
