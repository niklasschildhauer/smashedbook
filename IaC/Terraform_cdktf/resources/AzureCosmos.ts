import { Construct } from "constructs";
import { Environment } from "../helpers/Environment";
import { CosmosdbAccount } from "@cdktf/provider-azurerm/lib/cosmosdb-account";
import { TerraformOutput } from "cdktf";

export const AzureCosmos = (scope: Construct, environment: Environment, resourceGroupName: string) => {
    const name = `mealplan-cosmos-${environment}`;

    const create = () => {
        const cosmos = new CosmosdbAccount(scope, name, {
            name: name,
            location: "germanywestcentral",
            resourceGroupName: resourceGroupName,
            offerType: "Standard",
            kind: "GlobalDocumentDB",
            consistencyPolicy: {
                consistencyLevel: "Session",
                maxIntervalInSeconds: 5,
                maxStalenessPrefix: 100
            },
            capabilities: [{
                name: "EnableServerless",
            }], 
            geoLocation: [{
                location: "germanywestcentral",
                failoverPriority: 0,
            }], 
        })

        new TerraformOutput(scope, "cosmos-connection-string", {
            value: cosmos.connectionStrings,
            sensitive: true
          });

        return cosmos
    }

    return {
        create,
        name
    }
}