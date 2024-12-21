import { ResourceGroup } from "@cdktf/provider-azurerm/lib/resource-group";
import { Environment } from "./helpers/Environment";
import { Construct } from "constructs";

export const AzureResourceGroup = (scope: Construct, environment: Environment) => {
    const name = `mealplan-cdktf-${environment}-rg`;
    const location = "germanywestcentral";

    const create = () => {
        return new ResourceGroup(scope, "cdktf-rg", {
            name: name,
            location: location,
          });
    }

    return {
        name,
        create
    }
}   
    