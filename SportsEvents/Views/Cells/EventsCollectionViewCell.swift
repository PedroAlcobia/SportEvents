//
//  EventsCollectionViewCell.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 18/01/2022.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateContainer: UIView!
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var favourite: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    
    private var eventModel: EventModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(eventModel: EventModel) {
        self.eventModel = eventModel
        
        self.dateContainer.layer.cornerRadius = self.dateContainer.frame.height / 4
        self.dateContainer.layer.masksToBounds = true
        self.dateContainer.layer.borderWidth = 1
        self.dateContainer.layer.borderColor = UIColor.systemBlue.cgColor
        
        self.dateValue.text = eventModel.getDateDiferenceTopresent()
        
        if #available(iOS 13.0, *) {
            self.favourite.image = eventModel.isFavourite() ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        } else {
            self.favourite.image = eventModel.isFavourite() ? UIImage(named: "star.fill") : UIImage(named: "star")
        }
        
        self.eventName.text = eventModel.eventName
    }
    
    func timerUpdated() {
        self.dateValue.text = self.eventModel.getDateDiferenceTopresent()
    }
}
