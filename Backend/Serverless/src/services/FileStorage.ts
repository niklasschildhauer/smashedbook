export enum ContentType {
    imagePng = "image/png",
    imageJpeg = "image/jpeg",
    unknown = "unknown"
} 

export interface FileStorage {
    save(file: ArrayBuffer, name: string, type: ContentType): Promise<void>;
    getFileData(name: string, type: ContentType): Promise<{data: Buffer, type: ContentType}>;
    getFileUrl(name: string, type: ContentType): Promise<{url: string}>;
}