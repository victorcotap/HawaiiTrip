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
            Text(viewModel.presentation?.title ?? "title").font(.title)
            Text(viewModel.presentation?.subtitle ?? "subtitle").font(.subheadline)
            List(viewModel.locations) { location in
                HStack {
                    Text(location.name).font(.body)
                    Text(location.description).font(.callout)
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
        let somePreviewMockStateManager: VacationLocationStateManagerType = VacationLocationStateManager()
        let viewModel = HawaiiViewModel(stateManager: somePreviewMockStateManager)
        HawaiiView(viewModel: viewModel)
    }
}
