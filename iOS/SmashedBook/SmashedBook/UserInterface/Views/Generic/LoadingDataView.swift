//
//  LoadingDataView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import SwiftUI

struct LoadingDataView<DataModel, Content: View>: View {
    var data: LoadingData<DataModel>
    let content: (_ item: DataModel) -> Content
    
    init(data: LoadingData<DataModel>, @ViewBuilder content: @escaping (_ item: DataModel) -> Content) {
        self.data = data
        self.content = content
    }
    
    var body: some View {
        switch data {
        case .notStarted:
            EmptyView()
        case .loading:
            ProgressView()
        case let .success(value):
            content(value)
        case let .failure(error):
            Text(error.localizedDescription)
        }
    }
}
