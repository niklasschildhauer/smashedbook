import { Construct } from "constructs";
import { Environment } from "./helpers/Environment";
import { StorageAccount, StorageAccountConfig } from "@cdktf/provider-azurerm/lib/storage-account";
import { TerraformOutput } from "cdktf";
import { StorageBlob } from "@cdktf/provider-azurerm/lib/storage-blob";
import path = require("path");
import fs = require("fs");

export const AzureStorageAccount = (scope: Construct, environment: Environment, resourceGroupName: string) => {
    const name = `mealplan${environment}`;

    const create = () => {
        const storageAccountConfig: StorageAccountConfig = {
            name: name,
            location: "germanywestcentral",
            resourceGroupName: resourceGroupName,
            accountReplicationType: "LRS",
            accountTier: "Standard",
            accountKind: "StorageV2",
            staticWebsite: {
                indexDocument: "index.html",
                error404Document: "404.html",
            },
        };

        const storageAccount = new StorageAccount(scope, "storageAccount", storageAccountConfig);
        uploadStaticWebsite(storageAccount);
       
        new TerraformOutput(scope, "storage-account-web-host", {
            value: storageAccount.primaryWebEndpoint,
          });
       
          new TerraformOutput(scope, "storage-account-web-endpoint", {
        value: storageAccount.primaryWebEndpoint,
        });
     
        return storageAccount
    }

    const uploadStaticWebsite = (storageAccount: StorageAccount) => {
        const container = "$web";
        const filePath = path.join(__dirname, "../../StaticWebsite/index.html");
        const indexContent = fs.readFileSync(filePath, 'utf8');
        const indexDocument = "index.html";
        const errorDocument = "404.html";
        const errorContent = "Error 404 - Page not found";

        new StorageBlob(scope, "index", {
            name: indexDocument,
            storageAccountName: storageAccount.name,
            storageContainerName: container,
            type: "Block",
            sourceContent: indexContent,
            contentType: "text/html",
        });

        new StorageBlob(scope, "error", {
            name: errorDocument,
            storageAccountName: storageAccount.name,
            storageContainerName: container,
            type: "Block",
            sourceContent: errorContent,
            contentType: "text/html",
        });
    }

    return {
        create,
        name
    }
}