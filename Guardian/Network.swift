//
//  Network.swift
//  Guardian
//
//  Created by Tomasz Kuzma on 06/10/2021.
//

import Foundation


//- tag - tone/recipes
//- show-tags - series
//- show-fields - thumbnail, headline

enum Filters {
    case showFields(fields : [AdditionalInfoField])
    case tagsToShow(tags: [TagToShow])
    case tagsToFilterBy(tags: [TagToFilter])
}

enum AdditionalInfoField: String {
    case thumbnail
    case headline
}

enum TagToFilter {
    case tone
    case recipes
}

enum TagToShow : String {
    case series
}
