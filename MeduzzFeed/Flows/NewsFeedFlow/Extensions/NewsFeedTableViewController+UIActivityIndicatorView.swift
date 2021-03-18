//
//  NewsFeedTableViewController+UIActivityIndicatorView.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 18.03.2021.
//

import UIKit

extension NewsFeedTableViewController {
    
    func createTableFooterSpinner(size: CGSize) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        activityIndicatorView.frame = CGRect(origin: .zero, size: size)
        return activityIndicatorView
    }
}
