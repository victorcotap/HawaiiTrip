//
//  File.swift
//  
//
//  Created by Victor Levasseur on 12/3/22.
//

import Foundation
import Combine

protocol VacationLocationStateManagerType {
    var statePublisher: Published<VacationState>.Publisher { get }
    var locationsPublisher: Published<[Location]>.Publisher { get }
    var copyPublisher: Published<VacationCopy?>.Publisher { get }

    /// Using Result here instead of throwing because we need to define our custom errors for 4XX answers
    func refreshVacationState() async -> Result<VacationState, Error>
    func refreshLocations() async -> Result<[Location], Error>
}

class VacationLocationService: VacationLocationStateManagerType {

    // @Resolved var network: NetworkingService

    @Published private var state: VacationState = .unknowned
    @Published private var locations: [Location] = []
    @Published private var copy: VacationCopy?

    var statePublisher: Published<VacationState>.Publisher { $state }
    var locationsPublisher: Published<[Location]>.Publisher { $locations }
    var copyPublisher: Published<VacationCopy?>.Publisher { $copy }

    func refreshVacationState() async -> Result<VacationState, Error> {
        await withCheckedContinuation({ continuation in
            /// Do the network call here using Future (See SuperAppService for reference)
            /// self.networking.makeApiRequest(...)

            // In case of success
            let apiResponse = OfflineData.testVacationStateResponse
            self.state = apiResponse.vacationState
            continuation.resume(returning: .success(self.state))

            // In case of some error
            //continuation.resume(returning: .failure(EmptyError()))
        })
    }

    func refreshLocations() async -> Result<[Location], Error> {
        await withCheckedContinuation({ continuation in
            /// Do the network call here using Future (See SuperAppService for reference)
            /// self.networking.makeApiRequest(...)

            let apiResponse = OfflineData.testLocationsResponse

            // In case of success
            continuation.resume(returning: .success(apiResponse.locations))
            self.locations = apiResponse.locations

            // In case of some error
            // continuation.resume(returning: .failure(EmptyError()))
        })
    }
}
