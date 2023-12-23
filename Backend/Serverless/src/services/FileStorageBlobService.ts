import { BlobSASPermissions, BlobServiceClient, BlockBlobClient, ContainerClient, SASProtocol, generateBlobSASQueryParameters } from "@azure/storage-blob";
import { FileStorage, ContentType } from "./FileStorage";
import { HttpError } from "../model/HttpError";
import { DefaultAzureCredential, DefaultAzureCredentialOptions } from "@azure/identity";


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

    async getFileData(name: string): Promise<{data: Buffer, type: ContentType}> {
        const blob = await this.blobStorage.findBlob(name);

        if (!blob) {
            throw new HttpError(404, `File ${name} not found`);
        }
        const contentType = (await blob.getProperties()).contentType as ContentType ?? ContentType.unknown;
        const downloadResponse = await blob.download();

        if (!downloadResponse.errorCode && downloadResponse?.readableStreamBody) {
            const data = await this.streamToBuffer(downloadResponse.readableStreamBody);
            return {data: data, type: contentType};
        } else {
            console.error(`Download of ${name} failed`);
            throw new HttpError(500, `Download of ${name} failed`);
        }
    }

    async getFileUrl(name: string): Promise<{url: string, expireDate: Date}> {
        const blob = await this.blobStorage.findBlob(name);

        if (!blob) {
            throw new HttpError(404, `File ${name} not found`);
        }
        return await this.blobStorage.createSASUrl(blob);
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
    constructor(
        private accountName = "mealplandev", 
        private blobService = new BlobServiceClient(
            `https://${accountName}.blob.core.windows.net`, 
            new DefaultAzureCredential({ 
                managedIdentityClientId: process.env["MANAGED_IDENTITY_CLIENT_ID"]
            })
      )) { }

    async getBlob(name: string, type: ContentType): Promise<BlockBlobClient> {
        const containerClient = await this.getContainer(this.getContainerName());
        return containerClient.getBlockBlobClient(this.getBlobName(name, type));
    }

    async findBlob(name: string): Promise<BlockBlobClient | undefined> {
        const containerClient = await this.getContainer(this.getContainerName());
        const blobs = containerClient.listBlobsFlat();
        for await (const blob of blobs) {
            if (blob.name.includes(name)) {
                return containerClient.getBlockBlobClient(blob.name);
            }
        }
        return undefined
    }

    async createSASUrl(blob: BlockBlobClient): Promise<{url: string, expireDate: Date}> {
        const TEN_MINUTES = 10 * 60 * 1000;
        const NOW = new Date();
        const TEN_MINUTES_BEFORE_NOW = new Date(NOW.valueOf() - TEN_MINUTES);
        const TEN_MINUTES_AFTER_NOW = new Date(NOW.valueOf() + TEN_MINUTES);

        // Best practice: delegation key is time-limited  
        // When using a user delegation key, container must already exist 
        const userDelegationKey = await this.blobService.getUserDelegationKey(
            TEN_MINUTES_BEFORE_NOW, 
            TEN_MINUTES_AFTER_NOW
        );

        const blobPermissionsRead = "r"
        
        const sasOptions = {
            blobName: blob.name,
            containerName: this.getContainerName(),                                           
            permissions: BlobSASPermissions.parse(blobPermissionsRead), 
            protocol: SASProtocol.Https,
            startsOn: TEN_MINUTES_BEFORE_NOW,
            expiresOn: TEN_MINUTES_AFTER_NOW
        };

        const sasToken = generateBlobSASQueryParameters(
            sasOptions,
            userDelegationKey,
            this.accountName 
        ).toString();

        const sasUrl = `https://${this.accountName}.blob.core.windows.net/${this.getContainerName()}/${blob.name}?${sasToken}`;
        console.log(`\nBlobUrl = ${sasUrl}\n`);

        return {url: sasUrl, expireDate: TEN_MINUTES_AFTER_NOW};
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