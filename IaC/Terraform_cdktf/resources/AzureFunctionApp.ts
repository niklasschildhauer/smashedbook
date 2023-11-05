import { Construct } from "constructs";
import { Environment } from "../helpers/Environment";
import { StorageAccount } from "@cdktf/provider-azurerm/lib/storage-account";
import { ResourceGroup } from "@cdktf/provider-azurerm/lib/resource-group";
import { ServicePlan } from "@cdktf/provider-azurerm/lib/service-plan";
import { LinuxFunctionApp } from "@cdktf/provider-azurerm/lib/linux-function-app";
import { TerraformOutput } from "cdktf";

export const AzureFunctionApp = (scope: Construct, environment: Environment, storageAccount: StorageAccount, resourceGroup: ResourceGroup, servicePlan: ServicePlan) => {
    const name = `mealplan-cdktf-${environment}-function-app`;
    const location = "germanywestcentral";

    const create = () => {
        const functionApp = new LinuxFunctionApp(scope, name, {
            name: name,
            location: location,
            storageAccountName: storageAccount.name,
            storageAccountAccessKey: storageAccount.primaryAccessKey,
            resourceGroupName: resourceGroup.name,
            servicePlanId: servicePlan.id,
            siteConfig: {
                use32BitWorker : false,
            },
            appSettings: {
                "FUNCTIONS_WORKER_RUNTIME": "node",
                "WEBSITE_NODE_DEFAULT_VERSION": "14",
            }
          });

          new TerraformOutput(scope, "function-app-name", {
            value: functionApp.name,
          });

          new TerraformOutput(scope, "function-app-default-hostname", {
            value: functionApp.defaultHostname,
          });

          return functionApp
    }

    return {
        name,
        create
    }
}   
    