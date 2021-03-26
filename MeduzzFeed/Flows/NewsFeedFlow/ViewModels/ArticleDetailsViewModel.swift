//
//  ArticleDetailsViewModel.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 23.03.2021.
//

import Foundation
import UIKit

enum ArticleDetailsViewModelLoadingType {
    case fullScreen
}

protocol ArticleDetailsViewModelInput {
    func viewDidLoad()
}

protocol ArticleDetailsViewModelOutput {
    var details: Observable<Details> { get }
    var loading: Observable<ArticleDetailsViewModelLoadingType?> { get }
    var error: Observable<String> { get }
    var image: Observable<UIImage?> { get }
}

protocol ArticleDetailsViewModel: ArticleDetailsViewModelInput, ArticleDetailsViewModelOutput {}

final class DefaultArticleDetailsViewModel: ArticleDetailsViewModel {
    
    var details: Observable<Details> = Observable(Details(title: "", subtitle: "", description: "", date: 0, imageUrl: "", meduzaUrl: ""))
    var loading: Observable<ArticleDetailsViewModelLoadingType?> = Observable(.none)
    var error: Observable<String> = Observable("")
    var image: Observable<UIImage?> = Observable(nil)
    
    var url: String!
    
    var request: MeduzaAPIRequest<ArticleWithDetailsAPIResource>?
    var imageRequest: LoadImageRequest?

    private func load(_ type: ArticleDetailsViewModelLoadingType) {
        loading.value = type
        
        let resource = ArticleWithDetailsAPIResource(detailsUrl: url)
        request = MeduzaAPIRequest(resource: resource)
        request?.execute { [weak self] details in
            guard let self = self else { return }
            
            if let details = details {
                self.details.value = details.toDetails()
                if let url = URL(string: details.root.og.image) {
                    self.loadImage(from: url)
                    return
                }
            } else {
                self.error.value = "Network connection issue"
            }
            self.loading.value = .none
        }
    }
    
    private func loadImage(from url: URL) {
        let request = LoadImageRequest(url: url)
        request.execute { [weak self] image in
            if let image = image {
                self?.image.value = image
            }
            self?.loading.value = .none
        }
        self.imageRequest = request
    }
}

extension DefaultArticleDetailsViewModel {
    func viewDidLoad() {
        load(.fullScreen)
    }
}
