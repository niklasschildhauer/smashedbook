import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AzurermProvider } from "@cdktf/provider-azurerm/lib/provider";
import { Environment } from "./helpers/Environment";
import { AzureResourceGroup } from "./resources/AzureResourceGroup";
import { AzureStorageAccount } from "./resources/AzureStorageAccount";
import { AzureServicePlan } from "./resources/AzureServicePlan";
import { AzureFunctionApp } from "./resources/AzureFunctionApp";

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

    new AzurermProvider(this, "azureFeature", {
      features: {},
    });

    const rg = AzureResourceGroup(this, parameters.environment).create();
    const storageAccount = AzureStorageAccount(this, parameters.environment, rg.name).create();
    const servicePlan = AzureServicePlan(this, parameters.environment, rg).create();
    // AzureCosmos(this, parameters.environment, rg.name).create();
    AzureFunctionApp(this, parameters.environment, storageAccount, rg, servicePlan).create();
  
  }
}

const app = new App();
AppStack.makeForEnv(app, Environment.DEV);
app.synth();
