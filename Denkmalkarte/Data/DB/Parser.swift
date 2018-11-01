//
//  Parser.swift
//  Denkmalkarte
//
//  Created by Florian Häusler on 29.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation
import MapKit

class Parser: NSObject, XMLParserDelegate {

    var parser = XMLParser()
    var denkmäler: [Denkmal]?
    var tempDenkmal: Denkmal?
    var currentElement = ""

    func readXML() -> [Denkmal]? {

        let fileURL = Bundle.main.url(forResource: "denkmaleTemp", withExtension: "xml")
        self.parser = XMLParser(contentsOf: fileURL!)!
        self.parser.delegate = self
        let success: Bool = self.parser.parse()
        if success {
            if let mockAnno = denkmäler {
                return mockAnno
            }
            print("success")

        } else {
            print("failure")

        }
        return nil
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        currentElement = elementName
        //print(currentElement)
        if elementName == "denkmal"{
            tempDenkmal = Denkmal()
        }

    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "denkmal"{
            if denkmäler != nil {
                if let denkmal = tempDenkmal {
                    let lon =  NumberFormatter().number(from: denkmal.long)?.doubleValue
                    let lat =  NumberFormatter().number(from: denkmal.lat)?.doubleValue
                    if (lon != nil && lat != nil) {
                        denkmal.coordinate = CLLocationCoordinate2D(latitude: Double(lat!), longitude: lon!)

                    }
                    denkmäler!.append(denkmal)
                }
            } else {
                if let denkmal = tempDenkmal {

                    let lon =  NumberFormatter().number(from: denkmal.long)?.doubleValue
                    let lat =  NumberFormatter().number(from: denkmal.lat)?.doubleValue
                    if (lon != nil && lat != nil) {
                        denkmal.coordinate = CLLocationCoordinate2D(latitude: Double(lat!), longitude: lon!)
                    }
                    denkmäler = [denkmal]

                }
            }
        }

    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundCahr = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if(!foundCahr.isEmpty) {
            if(currentElement=="id") {
                //tempDenkmal?.id = Int(foundCahr)
                print(foundCahr)
                // print("id",foundCahr)
            } else if (currentElement=="description") {
                //append() make it posible slowly
                tempDenkmal?.title?.append(foundCahr)
            } else if(currentElement=="location") {
                tempDenkmal?.location.append(foundCahr)
            } else if(currentElement=="street") {
                tempDenkmal?.street.append(foundCahr)

            } else if(currentElement=="date") {
                tempDenkmal?.date.append(foundCahr)

            } else if(currentElement=="execution") {
                tempDenkmal?.execution.append(foundCahr)

            } else if(currentElement=="builder-owner") {
                tempDenkmal?.builderOwner.append(foundCahr)

            } else if(currentElement=="literature") {
                tempDenkmal?.literature.append(foundCahr)

            } else if(currentElement=="design") {
                tempDenkmal?.design.append(foundCahr)

            } else if(currentElement=="latitude") {
                tempDenkmal?.lat.append(foundCahr)

            } else if(currentElement=="longitude") {
                tempDenkmal?.long.append(foundCahr)

            }

        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("failure error: ", parseError)
    }
}
