//
//  Csv.swift
//  German
//
//  Created by Lauriane Mollier on 11/1/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation
import CodableCSV

struct Csv {
    
    static func toCsv(verb: Verb) -> [String] {
        [verb.temps.infinitive.value,
         verb.temps.present.value,
         verb.temps.simplePast.value,
         verb.temps.pastParticiple.value,
         verb.level.rawValue,
         verb.translation(Lang.en),
         verb.translation(Lang.es)
         ]
    }
    
    static let csvTitle: [String] = ["Infinitiv","present","simplePast","pastParticiple","level","Englsh","Spanish"]
    
    static func shareButton() {
        let fileName = "caca.csv"
        var fileURL: URL?
        do {
            let path = try FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
            fileURL = path.appendingPathComponent(fileName)
        } catch {
            print("error creating file")
            SpeedLog.print(error)
        }
        
        if let file = fileURL {
            do {
                let writer = try CSVWriter(fileURL: file, append: false)

                try writer.write(row: csvTitle)
                SpeedLog.print(csvTitle.joined(separator:","))
                for verb in Verbs.verbs {
                    let row = toCsv(verb: verb)
                    try writer.write(row: row)
                    try writer.endRow()
                    SpeedLog.print(row.joined(separator:","))
                }
                try writer.endEncoding()
            }
            catch {
                SpeedLog.print("Fail to write in csv file")
                SpeedLog.print(error)
            }
        }
    }
}
