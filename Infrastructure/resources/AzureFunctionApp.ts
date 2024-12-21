import { Construct } from "constructs";
import { Environment } from "./helpers/Environment";
import { StorageAccount } from "@cdktf/provider-azurerm/lib/storage-account";
import { ResourceGroup } from "@cdktf/provider-azurerm/lib/resource-group";
import { ServicePlan } from "@cdktf/provider-azurerm/lib/service-plan";
import { LinuxFunctionApp } from "@cdktf/provider-azurerm/lib/linux-function-app";
import { TerraformOutput } from "cdktf";
import { AzureUserAssignedManagedId } from "./AzureUserAssignedManagedId";
import { RoleAssignment } from "@cdktf/provider-azurerm/lib/role-assignment";
import { ApplicationInsights } from "@cdktf/provider-azurerm/lib/application-insights";

export const AzureFunctionApp = (scope: Construct, environment: Environment, storageAccount: StorageAccount, resourceGroup: ResourceGroup, servicePlan: ServicePlan, applicationInsights: ApplicationInsights) => {
    const name = `mealplan-cdktf-${environment}-function-app`;
    const location = "germanywestcentral";

    const create = () => {
        const managedId = AzureUserAssignedManagedId(scope, environment, resourceGroup).create()

        new RoleAssignment(scope, "storage-account-role-assignment", {
          scope: storageAccount.id,
          principalId: managedId.principalId,
          roleDefinitionName: "Storage Blob Data Owner",
        });

        const functionApp = new LinuxFunctionApp(scope, name, {
            name: name,
            location: location,
            storageAccountName: storageAccount.name,
            // TODO: use managed identity instead of access key! 
            storageAccountAccessKey: storageAccount.primaryAccessKey,
            resourceGroupName: resourceGroup.name,
            servicePlanId: servicePlan.id,
            functionsExtensionVersion: "~4",
            identity: {
              type: "UserAssigned",
              identityIds: [managedId.id],
            },
            siteConfig: {
                use32BitWorker : false,
                applicationStack: {
                  nodeVersion: "18",
                },
                applicationInsightsConnectionString: applicationInsights.connectionString,
                applicationInsightsKey: applicationInsights.instrumentationKey,
            },
            appSettings: {
                "WEBSITE_RUN_FROM_PACKAGE": "1",
                "MANAGED_IDENTITY_CLIENT_ID": managedId.clientId,
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
    