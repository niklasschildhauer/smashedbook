import { Construct } from "constructs";
import { Environment } from "./helpers/Environment";
import { ResourceGroup } from "@cdktf/provider-azurerm/lib/resource-group";
import { LogAnalyticsWorkspace } from "@cdktf/provider-azurerm/lib/log-analytics-workspace";


export const AzureLogAnalyticsWorkspace = (scope: Construct, environment: Environment, resourceGroup: ResourceGroup) => {
    const name = `mealplan-cdktf-${environment}-log-analytics-workspace`;

    const create = () => {
        return new LogAnalyticsWorkspace(scope, name, {
            name: name,
            location: resourceGroup.location,
            resourceGroupName: resourceGroup.name,
            sku: "PerGB2018",
            retentionInDays: 30,    
        })
    }

    return {
        create
    }
}