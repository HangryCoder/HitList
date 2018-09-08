//
//  PersonTableViewCell.swift
//  HitList
//
//  Created by Sonia Wadji on 14/08/18.
//  Copyright © 2018 genora. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personAge: UILabel!
    @IBOutlet weak var personPhoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPerson(person: PersonModel){
        personName.text = person.name
        personAge.text = "\(person.age)"
        personPhoneNumber.text = person.phoneNumber
    }
    
}
