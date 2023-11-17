import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { RecipeDatabaseCosmosDB } from "../services/RecipeDatabaseCosmosDB";
import { HttpError } from "../model/HttpError";


export async function GetRecipe(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);

    try {
        const recipeDatabase = new RecipeDatabaseCosmosDB()
        const recipe = await recipeDatabase.get(request.params.id);
        return { body: JSON.stringify(recipe) };

    } catch (error) {
        if (error instanceof HttpError) {
            return { status: error.status, body: error.message };
        } else {
            return { status: 500, body: `Internal server error ${error}` };
        }
    }
};

app.http('getRecipe', {
    methods: ['GET'],
    route: 'recipe/{id}',
    authLevel: 'anonymous',
    handler: GetRecipe
});
