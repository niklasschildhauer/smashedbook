import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AzurermProvider } from "@cdktf/provider-azurerm/lib/provider";
import { Environment } from "./resources/helpers/Environment";
import { AzureResourceGroup } from "./resources/AzureResourceGroup";
import { AzureStorageAccount } from "./resources/AzureStorageAccount";
import { AzureServicePlan } from "./resources/AzureServicePlan";
import { AzureFunctionApp } from "./resources/AzureFunctionApp";
import { AzureLogAnalyticsWorkspace } from "./resources/AzureLogAnalyticsWorkspace";
import { AzureApplicationInsights } from "./resources/AzureApplicationInsights";

class AppStack extends TerraformStack {
  static makeForEnv = (
		app: Construct,
		environment: Environment
	) => {
		new AppStack(app, `MealPlan_${environment}`, {
			environment: environment
		})
	}

  constructor(
    scope: Construct, 
    id: string, 
    parameters: {
      environment: Environment
    }
  ) {
    super(scope, id);

    new AzurermProvider(this, "azurermProvider", {
        features: {
            resourceGroup: {
                preventDeletionIfContainsResources: true,
            },
        },
    });

    const rg = AzureResourceGroup(this, parameters.environment).create();
    const storageAccount = AzureStorageAccount(this, parameters.environment, rg.name).create();
    const servicePlan = AzureServicePlan(this, parameters.environment, rg).create();
    // AzureCosmos(this, parameters.environment, rg.name).create();
    const logAnalyticsWorkspace = AzureLogAnalyticsWorkspace(this, parameters.environment, rg).create();
    const applicationInsights = AzureApplicationInsights(this, parameters.environment, rg, logAnalyticsWorkspace).create();
    AzureFunctionApp(this, parameters.environment, storageAccount, rg, servicePlan, applicationInsights).create();
  
  }
}

const app = new App();
AppStack.makeForEnv(app, Environment.DEV);
app.synth();
