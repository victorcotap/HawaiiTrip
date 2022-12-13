//
//  File.swift
//  
//
//  Created by Victor Levasseur on 12/3/22.
//

import Foundation
import UIKit
import SwiftUI

struct HawaiiViewVacationStatePresentation {
    let title: String
    let subtitle: String
    let state: String
    let uiColor: UIColor
    let color: Color
}

enum HawaiiViewModelState {
    case loading
    case ready
}

class HawaiiViewModel: ObservableObject {
    private var stateManager: VacationLocationStateManagerType

    @Published var state: HawaiiViewModelState = .loading
    @Published var locations: [Location] = []
    @Published var presentation: HawaiiViewVacationStatePresentation?

    init(stateManager: VacationLocationStateManagerType) {
        self.stateManager = stateManager
        // Example of combining multiple StateManager publishers to determine View Model properties
        stateManager.statePublisher.combineLatest(stateManager.copyPublisher).sink { outputs in
            guard let copy = outputs.1 else { return }
            let vacationState = outputs.0

            self.state = .ready

            // Example of how to set presentation based on state
            let stateValue: String
            switch vacationState {
            case .unknowned:
                stateValue = "State is missing"
            default:
                stateValue = "All is good in the hood"
            }

            // Presentation is now bound and always updated
            self.presentation = HawaiiViewVacationStatePresentation(
                title: copy.title,
                subtitle: copy.subtitle,
                state: stateValue,
                uiColor: .systemIndigo,
                color: .white
            )
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
