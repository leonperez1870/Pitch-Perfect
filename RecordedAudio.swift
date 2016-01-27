//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Leoncio Perez on 1/24/16.
//  Copyright © 2016 Leoncio Perez. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}