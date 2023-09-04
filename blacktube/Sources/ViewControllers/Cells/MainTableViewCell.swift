//
//  MainTableViewCell.swift
//  blacktube
//
//  Created by 조규연 on 2023/09/04.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publishLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
