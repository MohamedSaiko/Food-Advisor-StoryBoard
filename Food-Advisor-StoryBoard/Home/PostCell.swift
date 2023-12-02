//
//  PostCell.swift
//  Food-Advisor-StoryBoard
//
//  Created by Mohamed Sayed on 02.12.23.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var postBody: UILabel!
    func configure(post: Post) {
        postBody.text = post.body
    }
}
