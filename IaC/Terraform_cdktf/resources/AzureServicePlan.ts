import { Construct } from "constructs";
import { Environment } from "../helpers/Environment";
import { ResourceGroup } from "@cdktf/provider-azurerm/lib/resource-group";
import { ServicePlan } from "@cdktf/provider-azurerm/lib/service-plan";

export const AzureServicePlan = (scope: Construct, environment: Environment, resourceGroup: ResourceGroup) => {
    const name = `mealplan-cdktf-${environment}-service-plan`;
    const location = "germanywestcentral";

    const create = () => {
        return new ServicePlan(scope, name, {
            name: name,
            location: location,
            resourceGroupName: resourceGroup.name,
            osType: "Linux",
            skuName: "Y1",
          });
    }

    return {
        name,
        create
    }
}   
    