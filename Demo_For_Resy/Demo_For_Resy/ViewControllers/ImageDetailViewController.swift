//
//  ImageDetailViewController.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/14/25.
//

import UIKit

class ImageDetailViewController: UIViewController {
    private var viewModel: ImageDetailViewModel
    private var imageDetailView = ImageDetailView()
    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
       
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(imageDetailView)
        setUpConstraints()
        bindDataToUI()
        viewModel.fetchImageDetail()
    }
    
    func setUpConstraints() {
        imageDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        imageDetailView.setUpImageViewConstraints(with: viewModel.isLandscapeImage)
    }
    
    private func bindDataToUI() {
        //ImageListViewModel's binding
        viewModel.isLoading.bind { [unowned self] (isLoading) in
            if isLoading { self.presentActivity() }
            else { self.dismissActivity() }
        }

        viewModel.error.bind { [unowned self] (error) in
            self.presentSimpleAlert(title: "Network Errors",
                                    message: error?.description ?? "")
        }
        
        viewModel.imageDetailModel.bind { [weak self] (imageDetailModel) in
            DispatchQueue.main.async {
                self?.imageDetailView.setupData(with: imageDetailModel)
            }
        }
    }
}

//MARK: - Spinner
extension ImageDetailViewController: ActivityPresentable {}
