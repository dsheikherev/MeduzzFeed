//
//  ArticleDetailsViewController.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 23.02.2021.
//

import UIKit

class ArticleDetailsViewController: UIViewController, ArticleDetailsView {

    var article = Article(title: "", subtitle: "", date: "")
    
    var onGoToOriginalLink: ((String) -> Void)?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var originalLinkButton: UIButton!
    
    @IBAction func originalLinkButtonTapped(_ sender: Any) {
        onGoToOriginalLink?("https://meduza.io")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
