//
//  NewsFeedTableViewModel.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 12.03.2021.
//

import Foundation

enum NewsFeedTableViewModelLoadingType {
    case fullScreen
    case nextPage
    case refresh
}

protocol NewsFeedTableViewModelInput {
    func viewDidLoad()
    func didRefreshFeed()
    func didLoadNextPage()
}

protocol NewsFeedTableViewModelOutput {
    var articles: Observable<[Article]> { get }
    var loading: Observable<NewsFeedTableViewModelLoadingType?> { get }
    var error: Observable<String> { get }
}

protocol NewsFeedTableViewModel: NewsFeedTableViewModelInput, NewsFeedTableViewModelOutput {}

final class DefaultNewsFeedTableViewModel: NewsFeedTableViewModel {
    
    var request: MeduzaAPIRequest<NewsFeedAPIResource>?
    
//    var fakeArticles = Array<Article>(repeating: Article(url: "url", title: "Россия должна быть не только свободной, но и счастливой", subtitle: "Последнее слово Алексея Навального, в котором он цитировал Библию, «Гарри Поттера» и «Рика и Морти»", date: 2021), count: 20)
    
    var articles: Observable<[Article]> = Observable([])
    var loading: Observable<NewsFeedTableViewModelLoadingType?> = Observable(.none)
    var error: Observable<String> = Observable("")
    
    var currentPage = 0
    
    private func load(_ type: NewsFeedTableViewModelLoadingType) {
        guard loading.value == .none else { return }
        loading.value = type
        
        currentPage = type != .nextPage ? 0 : currentPage + 1
        
        let resource = NewsFeedAPIResource(pageNumber: currentPage)
        request = MeduzaAPIRequest(resource: resource)
        request?.execute { [weak self] newsFeed in
            guard let self = self else { return }
            if let newsFeed = newsFeed {
                self.updateNewsFeed(with: newsFeed.toArticles())
            } else{
                self.error.value = "Network connection issue"
            }
            self.loading.value = .none
        }
        
        
//        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
//            guard let self = self else { return }
//
//            self.articles.value = type == .nextPage ? self.articles.value + self.fakeArticles : self.fakeArticles
//            self.loading.value = .none
//        }
    }
    
    private func updateNewsFeed(with articles: [Article]) {
        switch loading.value {
            case .fullScreen, .refresh:
                var newArticles = articles
                newArticles.sort { $0.date > $1.date}
                self.articles.value = newArticles
            case .nextPage:
                var appended = self.articles.value
                appended += articles
                appended.sort { $0.date > $1.date }
                self.articles.value = appended
            default:
                break
        }
    }

}

extension DefaultNewsFeedTableViewModel {
    func viewDidLoad() {
        load(.fullScreen)
    }
    
    func didRefreshFeed() {
        load(.refresh)
    }
    
    func didLoadNextPage() {
        load(.nextPage)
    }
}
