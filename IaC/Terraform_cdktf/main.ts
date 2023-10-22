import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AzurermProvider } from "@cdktf/provider-azurerm/lib/provider";
import { Environment } from "./helpers/Environment";
import { AzureResourceGroup } from "./resources/AzureResourceGroup";
import { AzureStorageAccount } from "./resources/AzureStorageAccount";

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
    AzureStorageAccount(this, parameters.environment, rg.name).create();
  }
}

const app = new App();
AppStack.makeForEnv(app, Environment.DEV);
app.synth();
