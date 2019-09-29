//
//  EventModel.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit
import RealmSwift

//I don't aware of all the code.
enum DutyIDType: String {
    
    //Flight Events - Flight from Departure Airport to Arrival Airport
    case FLT
    
    //Day Off - Not scheduled to work.
    case DO
    
    //Standby Events - On reserve duty. Can be called by the airline any time.
    case SBY
    
    //Layover Events - When you sleep at a Arrival Airport and fly out later.
    case OFD
    
    //Simulator / Training Events - Training Course
    case POS
    
    //Report Event - Start for a day of working. A day can have multiple flights.
    case REPORT
    
    //Simulator / Training Events - Training Course
    case TRAINING
    
    //Debrief Events - End for a day of working.
    case DEBRIEF
}

enum DutyCodeType: String {
    
    case REPORT
    case FLIGHT
    case LAYOVER
    case Standby
    case OFF
    case POSITIONING
    case DEBRIEF
}

// MARK: - EventModel
class EventModel: Object, Codable {
    
    @objc dynamic var flightnr = "N/A"
    @objc dynamic var date = ""
    @objc dynamic var aircraftType = "N/A"
    @objc dynamic var tail = "N/A"
    @objc dynamic var departure = "N/A"
    @objc dynamic var destination = "N/A"
    @objc dynamic var timeDepart = "N/A"
    @objc dynamic var timeArrive = "N/A"
    @objc dynamic var dutyID = ""
    @objc dynamic var dutyCode = ""
    @objc dynamic var captain = "N/A"
    @objc dynamic var firstOfficer = "N/A"
    @objc dynamic var flightAttendant = "N/A"
    
    @objc dynamic var dutyCodeImage : String {
        get {
            switch dutyID {
            case DutyIDType.FLT.rawValue:
                return "\u{f072}"
            case DutyIDType.OFD.rawValue:
                return "\u{f0f2}"
            case DutyIDType.SBY.rawValue:
                return "\u{f0ea}"
            case DutyIDType.POS.rawValue:
                return "\u{f0b2}"
            case DutyIDType.DO.rawValue:
                return "\u{f0b1}"
            case DutyIDType.REPORT.rawValue:
                return "\u{f017}"
            case DutyIDType.TRAINING.rawValue:
                return "\u{f15c}"
            case DutyIDType.DEBRIEF.rawValue:
                return "\u{f15c}"
            default:
                return ""
            }
        }
    }

    @objc dynamic var formattedDate: String? {
        get {
            let dates = date.toDate(withFormat: "dd/MM/yyyy")
            guard let formattedString = dates?.toString(withFormat: "dd MMM yyyy") else {
                return date
            }
            return formattedString
        }
    }

    @objc dynamic var departureDestination: String {
        get {
            if dutyCode == DutyCodeType.Standby.rawValue {
                return DutyCodeType.Standby.rawValue
            }

            return departure + " - " + destination
        }
    }

    @objc dynamic var departArrivalTime: String {
        get {
            if timeDepart == "" || timeArrive == "" {
                return ""
            }
            return timeDepart + " - " + timeArrive
        }
    }

    @objc dynamic var matchCrew: String {
        get {
            if dutyCode == DutyCodeType.Standby.rawValue {
                return "Match Crew"
            }
            return ""
        }
    }

    @objc dynamic var subtitleDescription: String {
        get {
            if dutyCode != DutyCodeType.FLIGHT.rawValue {
                return departure
            }
            return ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case flightnr = "Flightnr"
        case date = "Date"
        case aircraftType = "Aircraft Type"
        case tail = "Tail"
        case departure = "Departure"
        case destination = "Destination"
        case timeDepart = "Time_Depart"
        case timeArrive = "Time_Arrive"
        case dutyID = "DutyID"
        case dutyCode = "DutyCode"
        case captain = "Captain"
        case firstOfficer = "First Officer"
        case flightAttendant = "Flight Attendant"
    }
    
    override static func ignoredProperties() -> [String] {
      return ["dutyCodeImage", "formattedDate", "departureDestination", "departArrivalTime", "matchCrew", "subtitleDescription"]
    }
}


extension Date {

    func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
