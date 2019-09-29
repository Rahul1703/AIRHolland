//
//  EventListTableViewCell.swift
//  Air Holland
//
//  Created by Rahul on 28/09/19.
//  Copyright © 2019 Rahul. All rights reserved.
//

import UIKit

class EventListTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var dutyCodeLabel: UILabel!
    @IBOutlet weak var departureDestinationLabel: UILabel!
    @IBOutlet weak var departArrivalTime: UILabel!
    @IBOutlet weak var matchCrew: UILabel!
    @IBOutlet weak var subtitleDescriptionLabel: UILabel!
    
    //MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataForCell(eventModel: EventModel) {
        
        let font = UIFont(name: "FontAwesome", size: 20)
        dutyCodeLabel.font = font
        dutyCodeLabel.text = eventModel.dutyCodeImage

        departureDestinationLabel.text = eventModel.departureDestination
        departArrivalTime.text = eventModel.departArrivalTime
        matchCrew.text = eventModel.matchCrew

        subtitleDescriptionLabel.text = eventModel.subtitleDescription
    }
}
