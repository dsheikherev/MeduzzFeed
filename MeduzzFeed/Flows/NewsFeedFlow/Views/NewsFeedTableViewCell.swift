//
//  NewsFeedTableViewCell.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 23.02.2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell, NewsFeedArticleParser {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func parse(_ article: Article) {
        titleLabel.text = article.title
        subtitleLabel.text = article.subtitle
        dateLabel.text = date(from: article.date)
    }
    
    private func date(from seconds: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
