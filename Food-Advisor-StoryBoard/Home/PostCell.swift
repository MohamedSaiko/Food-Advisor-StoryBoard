//
//  PostCell.swift
//  Food-Advisor-StoryBoard
//
//  Created by Mohamed Sayed on 02.12.23.
//

import UIKit

final class PostCell: UITableViewCell {
    
    @IBOutlet private weak var bodyLabel: UILabel!
    
    func configure(post: Post) {
        bodyLabel.text = String(post.id)
    }
}
