import { app, HttpRequest, HttpResponseInit, InvocationContext, output, input } from "@azure/functions";

const cosmosInput = input.cosmosDB({
    databaseName: 'MealPlanDatabase',
    collectionName: 'Recipes',
    connectionStringSetting: 'CosmosDbConnectionString',
});

export async function GetRecipes(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);
    cosmosInput.id = request.params.id;
    
    return { body: JSON.stringify(context.extraInputs.get(cosmosInput)) };
};

app.http('getRecipes', {
    methods: ['GET'],
    route: 'recipes',
    authLevel: 'anonymous',
    extraInputs: [cosmosInput],
    handler: GetRecipes
});
