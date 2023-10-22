import { Construct } from "constructs";
import { Environment } from "../helpers/Environment";
import { AzurermBackend } from "cdktf";
import { AzureStorageAccount } from "./AzureStorageAccount";
import { AzureResourceGroup } from "./AzureResourceGroup";

export const AzureBackend = (scope: Construct, environment: Environment) => {
    const name = `mealplan-cdktf-${environment}-rg`;
    const containerName = "mealplan-cdktf-state";

    const create = () => {
        return new AzurermBackend(scope, {
			containerName: containerName,
			key: `env_${environment}`,
			storageAccountName: AzureStorageAccount(scope, environment, name).name,
			resourceGroupName: AzureResourceGroup(scope, environment).name
		})
    }

    return {
        name,
        create
    }
}   