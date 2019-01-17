//
//  QuranDB.swift
//  QuranAcademy
//
//  Created by Ayub on 13/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import SQLite

class QuranDB {
    private let ayats = Table("ayats")
    private let words = Table("words")
    private let sura = Expression<Int>("sura")
    private let ayat = Expression<Int>("ayat")
    private let order = Expression<Int>("order")
    private let text = Expression<String>("text")

    static let instance = QuranDB()
    private let db: Connection?

    private init() {
        let path = Bundle.main.path(forResource: "quranDB", ofType: "db")
        do {
            db = try Connection(path ?? "")
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    func getAyats(suraNumber: Int) -> [Ayats] {
        var ayats = [Ayats]()
        do {
            for i in try db!.prepare(self.ayats.filter(self.sura == suraNumber)) {
                ayats.append(Ayats(sura: i[sura], ayat: i[ayat], text: i[text]))
            }
        } catch {
            print("Select failed")
        }
        
        return ayats
    }
    
    func getWords() -> [Words] {
        var words = [Words]()
        do {
            for i in try db!.prepare(self.ayats) {
                words.append(Words(sura: i[sura], ayat: i[ayat], text: i[text], order: i[order]))
            }
        } catch {
            print("Select failed")
        }
        
        return words

    }
    
}
