//
//  ImageDetailView.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/14/25.
//

import UIKit

class ImageDetailView: UIView {
    init() {
        super.init(frame: CGRect.zero)
        addSubview(photoView)
        addSubview(authorNameLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoView.widthAnchor.constraint(equalTo: widthAnchor),
            authorNameLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10),
            authorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    func setUpPhotoViewHeightConstraints(width: CGFloat, height: CGFloat) {
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: height/width).isActive = true
    }
    
    func setUpImageViewConstraints(with isLandscape: Bool) {
        if isLandscape {
            photoView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -44).isActive = true
        } else {
            photoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
    }
    
    func setupData(with model: ImageDetailModel?) {
        authorNameLabel.text = model?.author
        photoView.load.request(with: URL(string: model?.download_url ?? ""), placeholder: UIImage(named: "placeholder"))
        setUpPhotoViewHeightConstraints(width: CGFloat(Double(model?.width ?? 0)), height: CGFloat(Double(model?.height ?? 0)))
    }
    
    lazy var authorNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var photoView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
