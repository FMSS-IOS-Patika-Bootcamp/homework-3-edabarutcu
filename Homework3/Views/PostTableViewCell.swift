//
//  PostTableViewCell.swift
//  Homework3
//
//  Created by detaysoft on 19.09.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var useIDLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpView(post: Post) {
        useIDLabel.text = "#\(post.id)"
        useIDLabel.text = "User \(post.userID)"
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }

}

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}
