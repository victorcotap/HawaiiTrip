//
//  File.swift
//  
//
//  Created by Victor Levasseur on 12/3/22.
//

import Foundation

/// Models
struct Location: Codable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
}

enum VacationState: Codable {
    case unknowned
    case working
    case onTheBeach
    case hangover
}
struct VacationCopy: Codable {
    let title: String
    let subtitle: String
}

/// Basic API Response
struct LocationAPIResponse: Codable {
    let locations: [Location]
}

/// Simulating that we are passing both state and BE copies on this response
struct VacationStateResponse: Codable {
    let vacationState: VacationState
    let copy: VacationCopy
}
struct EmptyError: Error { }
