import { Construct } from "constructs";
import { Environment } from "../helpers/Environment";
import { StorageAccount, StorageAccountConfig } from "@cdktf/provider-azurerm/lib/storage-account";

export const AzureStorageAccount = (scope: Construct, environment: Environment, resourceGroupName: string) => {
    const name = `mealplan${environment}`;

    const create = () => {
        const storageAccountConfig: StorageAccountConfig = {
            name: name,
            location: "germanywestcentral",
            resourceGroupName: resourceGroupName,
            accountReplicationType: "LRS",
            accountTier: "Standard"
        };
        return new StorageAccount(scope, "storageAccount", storageAccountConfig);
    }

    return {
        create,
        name
    }
}