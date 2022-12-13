//
//  File.swift
//  
//
//  Created by Victor Levasseur on 12/3/22.
//

import Foundation

struct OfflineData {
    private static let testLocations: [Location] = [
        Location(name: "Airport", description: "HNL"),
        Location(name: "Waikiki", description: "Pretty touristy"),
        Location(name: "Shipwreck Dive Site", description: "Deep"),
    ]
    private static let testVacationState: VacationState = .working
    private static let testVacationCopy: VacationCopy = VacationCopy(
        title: "Here's the current state of your vacation",
        subtitle: "Results may vary"
    )

    static let testVacationStateResponse: VacationStateResponse = VacationStateResponse(
        vacationState: OfflineData.testVacationState,
        copy: OfflineData.testVacationCopy
    )
    static let testLocationsResponse: LocationAPIResponse = LocationAPIResponse(
        locations: OfflineData.testLocations
    )
}
