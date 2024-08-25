//
//  RecipeDetailStepsView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 14.01.24.
//

import SwiftUI

struct RecipeDetailStepsView: View {
    @Binding var steps: [RecipeStepModel]
    @Environment(RecipeDetailCoordinator.self) var coordinator
    
    var body: some View {
        ListSectionView(title: "Schritte",
                        content: {
            ForEach($steps.indices, id: \.self) { stepIndex in
                HStack(alignment: .firstTextBaseline, spacing: LayoutConstants.horizontalSpacing) {
                    Text(stepName(for: stepIndex))
                        .fontWeight(.semibold)
                        .font(.footnote)
                    Text(steps[stepIndex].description)
                }
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: deleteStep)
            .onMove(perform: moveStep)
        })
    }
    
    func stepName(for index: Int) -> String {
        return "\(index + 1)."
    }
    
    func moveStep(fromOffsets source: IndexSet, toOffset destination: Int) {
        steps.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteStep(atOffsets offsets: IndexSet) {
        steps.remove(atOffsets: offsets)
    }
}

#Preview {
    List {
        RecipeDetailStepsView(steps: .constant([.init(description: "Das ist eine Beschreibung eines Rezeptschrittes"), .init(description: "Danach kommt ein weiterer Rezeptschritt.")]))
            .environment(RecipeDetailCoordinator(recipeModel: recipeModelMock))
    }

}
