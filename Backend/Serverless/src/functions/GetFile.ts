import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { HttpError } from "../model/HttpError";
import { FileStorageBlobService } from "../services/FileStorageBlobService";

export async function GetFile(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);
    try {
        const fileStorage = new FileStorageBlobService()
        const fileName = request.params.fileName
        const { data, type } = await fileStorage.getFileData(fileName)
        
        return { status: 200, body: data, headers: { "content-type": type } }
    } catch (error) {
        if (error instanceof HttpError) {
            return { status: error.status, body: error.message };
        } else {
            console.error(error);
            return { status: 500, body: `Internal server error` };
        }
    }
};

app.http('getFile', {
    methods: ['GET'],
    route: 'file/{fileName}',
    authLevel: 'anonymous',
    handler: GetFile
}); 

