//
//  InterestedSelectionUIModel.swift
//  LadyBug
//
//  Created by SAMEH on 22/02/2021.
//

import Foundation

struct InterestedSelectionUIModel {
    let title: String
    let data : [String]

    var numberOfItems: Int {
        return data.count
    }

    subscript(index: Int) -> String {
        return data[index]
    }
}

extension InterestedSelectionUIModel {
    //  Putting a new init method here means we can
    //  keep the original, memberwise initaliser.
    init(title: String, data: String...) {
        self.title = title
        self.data  = data
    }
}
