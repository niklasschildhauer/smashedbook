import { BlobServiceClient, BlockBlobClient, ContainerClient } from "@azure/storage-blob";
import { FileStorage, ContentType } from "./FileStorage";
import { Writable } from "stream";
import { HttpError } from "../model/HttpError";
import { log } from "console";

export class FileStorageBlobService implements FileStorage {
    constructor(
        private blobStorage = new BlobStorage()
        ) { }

    async save(file: ArrayBuffer, name: string, type: ContentType): Promise<void> {
        const blob = await this.blobStorage.getBlob(name, type);
        const respone = await blob.uploadData(file, { blobHTTPHeaders: { blobContentType: type} });

        if(respone.errorCode) {
            throw new HttpError(500, "File upload failed");
        }
    }

    async get(name: string): Promise<{data: Buffer, type: ContentType}> {
        const blob = await this.blobStorage.findBlob(name);
        const contentType = (await blob?.getProperties()).contentType as ContentType ?? ContentType.unknown;
        if (!blob) {
            throw new HttpError(404, `File ${name} not found`);
        }
        const downloadResponse = await blob.download();

        if (!downloadResponse.errorCode && downloadResponse?.readableStreamBody) {
            console.log(`Download of ${name} succeeded`);
            const data = await this.streamToBuffer(downloadResponse.readableStreamBody);
            return {data: data, type: contentType};
        } else {
            console.error(`Download of ${name} failed`);
            throw new HttpError(500, `Download of ${name} failed`);
        }
    }
    
    private streamToBuffer(readableStream: NodeJS.ReadableStream): Promise<Buffer> {
        return new Promise((resolve, reject) => {
            const chunks: any[] = [];
            readableStream.on('data', (data) => {
                chunks.push(data instanceof Buffer ? data : Buffer.from(data));
            });
            readableStream.on('end', () => {
                resolve(Buffer.concat(chunks));
            });
            readableStream.on('error', reject);
        });
    }
}

class BlobStorage {
    constructor(private blobService = BlobServiceClient.fromConnectionString(process.env.BlobServiceConnectionString)) { }

    async getBlob(name: string, type: ContentType): Promise<BlockBlobClient> {
        const containerClient = await this.getContainer(this.getContainerName());
        return containerClient.getBlockBlobClient(this.getBlobName(name, type));
    }

    async findBlob(name: string): Promise<BlockBlobClient | undefined> {
        const containerClient = await this.getContainer(this.getContainerName());
        const blobs = containerClient.listBlobsFlat();
        for await (const blob of blobs) {
            if (blob.name.includes(name)) {
                console.log(`Found blob ${name}`);  
                return containerClient.getBlockBlobClient(blob.name);
            }
        }
        return undefined
    }

    async getContainer(containerName: string): Promise<ContainerClient> {
        const containerClient = this.blobService.getContainerClient(containerName);
        await containerClient.createIfNotExists();
        return containerClient;
    }

    getContainerName() {
        return "recipes"
    }

    getBlobName(name: string, type: ContentType) {
        switch (type) {
            case ContentType.imagePng:
                return `images/${name}.png`;
            case ContentType.imageJpeg:
                return `images/${name}.jpeg`;
            default:
                return `default/${name}`;
        }
    }
}