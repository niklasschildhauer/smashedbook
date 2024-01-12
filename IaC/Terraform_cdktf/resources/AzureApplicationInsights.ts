import { Construct } from "constructs";
import { Environment } from "../helpers/Environment";
import { ResourceGroup } from "@cdktf/provider-azurerm/lib/resource-group";
import { LogAnalyticsWorkspace } from "@cdktf/provider-azurerm/lib/log-analytics-workspace";
import { ApplicationInsights } from "@cdktf/provider-azurerm/lib/application-insights";


export const AzureApplicationInsights = (scope: Construct, environment: Environment, resourceGroup: ResourceGroup, logAnalyticsWorkspace: LogAnalyticsWorkspace) => {
    const name = `mealplan-cdktf-${environment}-insights`;

    const create = () => {
        return new ApplicationInsights(scope, 'micPortalLogAnalyticsWorkspace', {
            name: name,
            location: resourceGroup.location,
            resourceGroupName: resourceGroup.name,
            workspaceId: logAnalyticsWorkspace.id,
            applicationType: "web",
        })
    }
    return { create }
}