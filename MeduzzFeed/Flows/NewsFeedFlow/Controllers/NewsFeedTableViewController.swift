//
//  NewsFeedTableViewController.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 22.02.2021.
//

import UIKit

class NewsFeedTableViewController: UIViewController, NewsFeedTableView {
    
    var onArticleSelected: ((Article) -> ())?
    
    var viewModel: NewsFeedTableViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableFooterSpinner: UIActivityIndicatorView?
    
//    var request: MeduzaAPIRequest<NewsFeedAPIResource>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFeedTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "Meduza.io"
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: NewsFeedTableViewModel) {
        viewModel.articles.observe(on: self) { [weak self] _ in self?.updateArticles() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
    }
    
    private func updateArticles() {
        tableView.reloadData()
    }
    
    private func updateLoading(_ loading: NewsFeedTableViewModelLoadingType?) {
        switch loading {
            case .fullScreen:
                tableView.tableFooterView = nil
                FullScreenSpinnerView.show()
            case .nextPage:
                tableFooterSpinner?.removeFromSuperview()
                tableFooterSpinner = createTableFooterSpinner(size: CGSize(width: tableView.frame.width, height: 50))
                tableView.tableFooterView = tableFooterSpinner
            case .none:
                tableView.tableFooterView = nil
                FullScreenSpinnerView.hide()
        }
    }
}

extension NewsFeedTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as? NewsFeedTableViewCell  else { return UITableViewCell() }
        
        cell.parse(viewModel.articles.value[indexPath.row])
        
        if indexPath.row == viewModel.articles.value.count - 1 {
            viewModel.didLoadNextPage()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articles.value[indexPath.row]
        onArticleSelected?(article)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
