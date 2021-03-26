//
//  ArticleDetailsViewController.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 23.02.2021.
//

import UIKit

class ArticleDetailsViewController: UIViewController, ArticleDetailsView {
    
    var onGoToOriginalLink: ((String) -> Void)?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var originalLinkButton: UIButton!
    
    @IBAction func originalLinkButtonTapped(_ sender: Any) {
        onGoToOriginalLink?(viewModel.details.value.meduzaUrl)
    }
    
    var viewModel: ArticleDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func hideAll(_ doHide: Bool) {
        imageView.isHidden = doHide
        titleLabel.isHidden = doHide
        secondTitleLabel.isHidden = doHide
        dateLabel.isHidden = doHide
        descriptionLabel.isHidden = doHide
        originalLinkButton.isHidden = doHide
    }
    
    private func bind(to viewModel: ArticleDetailsViewModel) {
        viewModel.details.observe(on: self) { [weak self] _ in self?.updateDetails() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError(message: $0) }
    }
    
    private func updateDetails() {
        guard viewModel.details.value.meduzaUrl != "" else { return }
        
        titleLabel.text = viewModel.details.value.title
        secondTitleLabel.text = viewModel.details.value.subtitle
        dateLabel.text = date(from: viewModel.details.value.date)
        descriptionLabel.text = viewModel.details.value.description
    }
    
    private func updateLoading(_ type: ArticleDetailsViewModelLoadingType?) {
        switch type {
            case .fullScreen:
                hideAll(true)
                FullScreenSpinnerView.show()
            case .none:
                FullScreenSpinnerView.hide()
                hideAll(false)
        }
    }
    
    private func date(from seconds: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func showError(message: String) {
        guard !message.isEmpty else { return }
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
