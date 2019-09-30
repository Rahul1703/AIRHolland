//
//  EventService.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit
import RealmSwift

//MARK:- EventService
class EventService: NSObject {
        
    //This method either perform api call or retrieve data from local storage.
    static func getEventList(isAPICall: Bool = false, onSuccess: @escaping (_ list: [String : [EventModel]])->(), onFailure: @escaping (_ message: String) -> ()) {
        
        //Getting data from local storage.
        let eventList: [EventModel] = RealmUtility.shared.getObjects()

        //We are checking 2 conditions here.
        //1. Pull to refresh is perform then we are calling api.
        //2. If there is no records in local storage then we are performing api call.
        if isAPICall || eventList.count == 0 {
            
            //API Call initiate
            getEventRequest(onSuccess: {
                
                let data = self.formatEventData(eventList: eventList)
                onSuccess(data)
            }) { (message) in
                onFailure(message)
            }
        }
        else {
            
            let data = self.formatEventData(eventList: eventList)
            onSuccess(data)
        }
    }
    
    //API Call.
    static func getEventRequest(onSuccess: @escaping ()->(), onFailure: @escaping (_ message: String) -> ()) {
        
        NetworkUtility.getData(endPoint: .EventList, requestMethod: .GET, successBlock: { (list) in
            
            //First will remove all the records to store new records.
            RealmUtility.shared.deleteAllObjects {
                
                //Storing new records.
                RealmUtility.shared.saveObjects(object: list)
                onSuccess()
            }

        }) { (message) in
            onFailure(message)
        }
    }
    
    //Formatting data based on our requirement. Perparing in group so we can easily map with our table.
    static func formatEventData(eventList: [EventModel]) -> [String: [EventModel]] {
        
        // prepapre grouping by date
        let groupDictionary = Dictionary(grouping: eventList, by: { (event) -> String in
            return event.formattedDate ?? ""
        })
        
        return groupDictionary
    }
}

