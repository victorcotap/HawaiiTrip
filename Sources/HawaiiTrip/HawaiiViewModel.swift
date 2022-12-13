//
//  File.swift
//  
//
//  Created by Victor Levasseur on 12/3/22.
//

import Foundation
import UIKit
import SwiftUI

struct HawaiiViewModelPresentation {
    let title: String
    let subtitle: String
    let state: String
    let uiColor: UIColor
    let color: Color
}

enum HawaiiViewModelState {
    case loading
    case error

    // Bundle presentation into viewModel state
    case ready(presentation: HawaiiViewModelPresentation)
}

class HawaiiViewModel: ObservableObject {
    private var stateManager: VacationLocationStateManagerType

    @Published var state: HawaiiViewModelState = .loading
    @Published var locations: [Location] = []

    // Sometimes we can directly use a presentation instead of bundling it into a state
    // @Published var presentation: HawaiiViewModelPresentation?

    init(stateManager: VacationLocationStateManagerType) {
        self.stateManager = stateManager
        // Example of combining multiple StateManager publishers to determine View Model properties
        stateManager.statePublisher.combineLatest(stateManager.copyPublisher).sink { outputs in
            let copy = outputs.1
            let vacationState = outputs.0

            guard let copy = copy, vacationState != .unknowned else {
                self.state = .loading
                return
            }

            // Example of how to set presentation based on state
            let stateValue: String
            switch vacationState {
            case .unknowned:
                stateValue = "State is missing"
            default:
                stateValue = "All is good in the hood"
            }

            // Presentation is now bound and always updated
            let presentation = HawaiiViewModelPresentation(
                title: copy.title,
                subtitle: copy.subtitle,
                state: stateValue,
                uiColor: .systemIndigo,
                color: .white
            )

            self.state = .ready(presentation: presentation)
        }

        // Example of directly reassigning to a ViewModel published property
        stateManager.locationsPublisher.assign(to: &$locations)
    }

    // Example of not using one directional binding but async / await call
    func buttonClicked() async {
        let newLocations = await stateManager.refreshLocations()
        switch newLocations {
        case .success(let success):
            self.locations = success
        case .failure(let failure):
            print("not cool cool cool", failure)
        }
    }

    func refresh() async {
        _ = await stateManager.refreshVacationState()
    }
}
