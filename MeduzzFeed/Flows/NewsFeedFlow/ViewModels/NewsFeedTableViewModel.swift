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
}

protocol NewsFeedTableViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
}

protocol NewsFeedTableViewModelOutput {
    var articles: Observable<[Article]> { get }
    var loading: Observable<NewsFeedTableViewModelLoadingType?> { get }
}

protocol NewsFeedTableViewModel: NewsFeedTableViewModelInput, NewsFeedTableViewModelOutput {}

final class DefaultNewsFeedTableViewModel: NewsFeedTableViewModel {
    
    var fakeArticles = Array<Article>(repeating: Article(title: "Россия должна быть не только свободной, но и счастливой", subtitle: "Последнее слово Алексея Навального, в котором он цитировал Библию, «Гарри Поттера» и «Рика и Морти»", date: "20 февраля 2021"), count: 20)
    
    var articles: Observable<[Article]> = Observable([])
    
    var loading: Observable<NewsFeedTableViewModelLoadingType?> = Observable(.none)
    
    private func loadNewsFeed() {
        if articles.value.isEmpty {
            loading.value = .fullScreen
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
                guard let self = self else { return }
                self.articles.value = self.fakeArticles
                self.loading.value = .none
            }
        }
    }

}

extension DefaultNewsFeedTableViewModel {
    func viewDidLoad() {
        loadNewsFeed()
    }
    
    func didLoadNextPage() {
        guard loading.value == .none else { return }
        loading.value = .nextPage
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            self.articles.value += self.fakeArticles
            self.loading.value = .none
        }
    }
}
