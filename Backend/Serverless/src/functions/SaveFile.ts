import { app, HttpRequest, HttpResponseInit, InvocationContext } from "@azure/functions";
import { HttpError } from "../model/HttpError";
import { FileStorageBlobService } from "../services/FileStorageBlobService";
import { v4 as uuid } from 'uuid';
import { ContentType } from "../services/FileStorage";

export async function SaveFile(request: HttpRequest, context: InvocationContext): Promise<HttpResponseInit> {
    context.log(`Http function processed request for url "${request.url}"`);
    try {
        context.log(`Create file storage`);

        const fileStorage = new FileStorageBlobService()
        const contentType = request.headers.get("content-type") as ContentType ?? ContentType.unknown
        const file = await request.arrayBuffer()
        const fileName = uuid()

        await fileStorage.save(file, fileName, contentType)   
             
        return { status: 200, body: fileName }
    } catch (error) {
        if (error instanceof HttpError) {
            return { status: error.status, body: error.message };
        } else {
            console.error(error);
            return { status: 500, body: `Internal server error` };
        }
    }
};

app.http('saveFile', {
    methods: ['POST'],
    route: 'file',
    authLevel: 'anonymous',
    handler: SaveFile
}); 



