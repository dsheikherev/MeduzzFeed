//
//  ArticleDetailsView.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation

protocol ArticleDetailsView: BaseView {
     
    var onGoToOriginalLink: ( (String) -> Void )? { get set }
}
