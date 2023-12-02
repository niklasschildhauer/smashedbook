import { Readable, Writable } from "stream";

export enum ContentType {
    imagePng = "image/png",
    imageJpeg = "image/jpeg",
    unknown = "unknown"
} 

export interface FileStorage {
    save(file: ArrayBuffer, name: string, type: ContentType): Promise<void>;
    get(name: string, type: ContentType): Promise<{data: Buffer, type: ContentType}>;
}