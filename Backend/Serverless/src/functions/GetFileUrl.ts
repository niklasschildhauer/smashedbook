import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { HttpError } from "../model/HttpError";
import { FileStorageBlobService } from "../services/FileStorageBlobService";

export async function GetFileUrl(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);
    try {
        const fileStorage = new FileStorageBlobService()
        const fileName = request.params.fileName
        const { url } = await fileStorage.getFileUrl(fileName)
        
        return { status: 200, body: url }

    } catch (error) {
        if (error instanceof HttpError) {
            return { status: error.status, body: error.message };
        } else {
            console.error(error);
            return { status: 500, body: `Internal server error` };
        }
    }
};

app.http('getFileUrl', {
    methods: ['GET'],
    route: 'fileUrl/{fileName}',
    authLevel: 'anonymous',
    handler: GetFileUrl
}); 

