//
//  FileManager.swift
//  QuranAcademy
//
//  Created by Ayub on 26/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

public extension FileManager {

    public var documentsURL: URL {
        return urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
    }
    
}
