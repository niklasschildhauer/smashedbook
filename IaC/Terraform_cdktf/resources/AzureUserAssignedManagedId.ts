import { Environment } from "../helpers/Environment";
import { Construct } from "constructs";
import { UserAssignedIdentity } from "@cdktf/provider-azurerm/lib/user-assigned-identity";
import { ResourceGroup } from "@cdktf/provider-azurerm/lib/resource-group";

export const AzureUserAssignedManagedId = (scope: Construct, environment: Environment, resourceGroup: ResourceGroup) => {
    const name = `mealplan-${environment}-function-uami`;
    const location = "germanywestcentral";

    const create = () => {
        return new UserAssignedIdentity(scope, name, {
            name: name,
            location: location,
            resourceGroupName: resourceGroup.name,
        });
    }

    return {
        name,
        create
    }
}   
    