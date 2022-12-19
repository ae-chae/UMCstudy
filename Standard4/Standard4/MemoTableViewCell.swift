//
//  MemoTableViewCell.swift
//  Standard4
//
//  Created by 윤채영 on 2022/10/20.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    @IBOutlet weak var uiTitle: UILabel!
    @IBOutlet weak var uiDate: UILabel!
    @IBOutlet weak var uiText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        uiTitle.text = nil
        uiDate.text = nil
        uiText.text = nil
    }
    
}
