//
//  CustomCollectionViewCelle.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 13.07.2022..
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private enum Constants {
        // MARK: contentView layout constants
        static let contentViewCornerRadius: CGFloat = 10
        
        // MARK: profileImageView layout constants
        static let imageHeight: CGFloat = 40
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let name: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .systemBlue
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UITextView = {
        let label = UITextView()
        label.textAlignment = .left
        label.textColor = .label
        label.isScrollEnabled = false
        label.textContainer.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white
        
        contentView.addSubview(imageView)
        contentView.addSubview(name)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupLayouts() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])

        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            name.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),//
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with framework: Framework) {
        imageView.image = UIImage(named: framework.imageName)
        name.text = framework.name
        descriptionLabel.text = framework.description
    }
    
}

extension CustomCollectionViewCell: Configurable {
    
    struct Data {
        let title: String
        let description: String
        let image: UIImage?
        let url: URL?
    }
    
    func configure(with data: Data) {
        // imageTitle = data.imageTitle
        // imageDescription
    }
    
    
}
