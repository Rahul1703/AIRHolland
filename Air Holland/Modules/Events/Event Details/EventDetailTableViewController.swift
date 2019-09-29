//
//  EventDetailTableViewController.swift
//  Air Holland
//
//  Created by Rahul on 29/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

class EventDetailTableViewController: UITableViewController {

    //MARK:- Outlets
    @IBOutlet weak var flightDateLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var aircraftTypeLabel: UILabel!
    @IBOutlet weak var tailLabel: UILabel!
    @IBOutlet weak var departureArrivalLabel: UILabel!
    @IBOutlet weak var timeArrivalDepartLabel: UILabel!
    @IBOutlet weak var captainLabel: UILabel!
    @IBOutlet weak var firstOfficerLabel: UILabel!
    @IBOutlet weak var firstAttendantLabel: UILabel!
    
    //MARK:- Properties
    var event: EventModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        initialize()
    }

    private func setupView() {

        self.clearsSelectionOnViewWillAppear = false

        flightNumberLabel.text = event?.flightnr
        aircraftTypeLabel.text = event?.aircraftType
        tailLabel.text = event?.tail
        flightDateLabel.text = event?.formattedDate
        departureArrivalLabel.text = event?.departureDestination
        timeArrivalDepartLabel.text = event?.departArrivalTime
        captainLabel.text = event?.captain
        firstOfficerLabel.text = event?.firstOfficer
        firstAttendantLabel.text = event?.flightAttendant
    }
    
    private func initialize() {
        
    }
}
