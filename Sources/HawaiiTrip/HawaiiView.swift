//
//  SwiftUIView.swift
//  
//
//  Created by Victor Levasseur on 12/12/22.
//

import SwiftUI

struct HawaiiView: View {

    @ObservedObject var viewModel: HawaiiViewModel

    var body: some View {
        VStack {
            if case let .ready(presentation) = viewModel.state {
                Text(presentation.title).font(.title)
                Text(presentation.subtitle).font(.subheadline)
                List(viewModel.locations) { location in
                    HStack {
                        Text(location.name).font(.body)
                        Text(location.description).font(.callout)
                    }
                }
            }
            Button("Refresh Me!") {
                Task {
                    await viewModel.refresh()
                }
            }
        }
    }
}

struct HawaiiView_Previews: PreviewProvider {
    static var previews: some View {
        let somePreviewMockStateManager: VacationLocationStateManagerType = VacationLocationService()
        let viewModel = HawaiiViewModel(stateManager: somePreviewMockStateManager)
        HawaiiView(viewModel: viewModel)
    }
}
