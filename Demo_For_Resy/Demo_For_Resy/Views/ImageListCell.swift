//
//  ImageListCell.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/14/25.
//

import UIKit

class ImageListCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        VStackView.addArrangedSubview(filenameLabel)
        VStackView.addArrangedSubview(imageDetailLabel)
        VStackView.addArrangedSubview(photoView)
        addSubview(VStackView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: 0.7).isActive = true
        NSLayoutConstraint.activate([
            VStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            VStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            VStackView.topAnchor.constraint(equalTo: topAnchor),
            VStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setUpDate(with model: ImageListCellViewModel, indexPath: IndexPath? = nil) {
        filenameLabel.text = model.getFileName()
        imageDetailLabel.text = model.getImageDetail()
        #if FLAG_OPTIMIZATION
        if model.isScrolling {
            photoView.load.cancelImageLoadingTaskWhileScrolling(with: model.getImageUrl(), placeholder: UIImage(named: "placeholder")) { operation in
                if operation == .disk, let indexPath = indexPath {
                    IndexPathsStorage.indexPathsOfCellWithLoadedImage.insert(indexPath)
                }
            }
        } else {
            photoView.load.request(with: model.getImageUrl(), placeholder: UIImage(named: "placeholder")) { _, _, operation  in
                if (operation == .disk || operation == .network), let indexPath = indexPath {
                    IndexPathsStorage.indexPathsOfCellWithLoadedImage.insert(indexPath)
                }
            }
        }
        #else
        photoView.load.request(with: model.getImageUrl(), placeholder: UIImage(named: "placeholder"))
        #endif
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.image = nil
        photoView.load.cancelCurrentImageLoad()
    }
    
    lazy var VStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    lazy var filenameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var imageDetailLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    lazy var photoView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
