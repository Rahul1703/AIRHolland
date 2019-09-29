//
//  EventService.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit
import RealmSwift

class EventService: NSObject {
        
    static func getEventList(isAPICall: Bool = false, completion: @escaping ([String : [EventModel]])->()) {
        
        let eventList: [EventModel] = RealmUtility.shared.getObjects()

        if isAPICall || eventList.count == 0 {
            
            getEventRequest {
                
                let data = self.formatEventData(eventList: RealmUtility.shared.getObjects())
                completion(data)
            }
        }
        else {
            let data = self.formatEventData(eventList: eventList)
            return completion(data)
        }
    }
    
    static func getEventRequest(completion: (()->())?) {
        
        // prepare request
        let dataRequest = DataRequest<[EventModel]>(url: APP_URL, method: .GET, headers: nil, parameters: [:], responeKeyPath: "")
        
        dataRequest.execute(success: { (list) in
            
            RealmUtility.shared.deleteAllObjects {
                RealmUtility.shared.saveObjects(object: list)
                completion?()
            }
        }) { (error) in
            completion?()
        }
    }
    
    static func formatEventData(eventList: [EventModel]) -> [String: [EventModel]] {
        
        // prepapre grouping by date
        let groupDictionary = Dictionary(grouping: eventList, by: { (event) -> String in
            return event.formattedDate ?? ""
        })
        
        return groupDictionary
    }
}

