//
//  ViewController.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/14/25.
//

import UIKit

class ImageListViewController: UITableViewController {
    
    private var viewModel = ImageListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        tableView.register(cellType: ImageListCell.self)
        bindDataToUI()
        fetchImageList()
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

        viewModel.shouldReloadData.bind { [unowned self] _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        #if FLAG_OPTIMIZATION
        viewModel.isScrolling.bind { [unowned self] (isScrolling) in
            viewModel.updatedScrollingValue(isScrolling: isScrolling)
            if !isScrolling {
                if var indexPaths = self.tableView.indexPathsForVisibleRows {
                    indexPaths = indexPaths.filter{ !IndexPathsStorage.indexPathsOfCellWithLoadedImage.contains($0) }
                    DispatchQueue.main.async {
                        self.tableView.reloadRows(at: indexPaths, with: .automatic)
                    }
                }
            }
        }
        #endif
    }
    
    private func fetchImageList() {
        viewModel.fetchImageList()
    }
}

// TableView delegate and dataSource
extension ImageListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ImageListCell.self,
                                                      for: indexPath)
        cell.setUpDate(with: viewModel.cellModelData(with: indexPath), indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modelData = viewModel.cellModelData(with: indexPath)
        let imageDetailViewModel = DefaultImageDetailViewModel(imageID: modelData.getImageID(), isLandscapeImage: modelData.isLandscapeImage())
        let imageDetailViewController = ImageDetailViewController(viewModel: imageDetailViewModel)
        navigationController?.pushViewController(imageDetailViewController, animated: true)
    }
    
    #if FLAG_OPTIMIZATION
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel.isScrolling.value = true
    }

    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            viewModel.isScrolling.value = false
        }
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.isScrolling.value = false
    }
    #endif
}

//MARK: - Spinner
extension ImageListViewController: ActivityPresentable {}
