//
//  NewsFeedTableViewController.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 22.02.2021.
//

import UIKit

class NewsFeedTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var fakeArticles = Array<Article>(repeating: Article(title: "Россия должна быть не только свободной, но и счастливой", subtitle: "Последнее слово Алексея Навального, в котором он цитировал Библию, «Гарри Поттера» и «Рика и Морти»", date: "20 февраля 2021"), count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFeedTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension NewsFeedTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = fakeArticles[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as? NewsFeedTableViewCell {
            cell.parse(article)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
