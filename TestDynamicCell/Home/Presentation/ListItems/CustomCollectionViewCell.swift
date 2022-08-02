//
//  CustomCollectionViewCelle.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 13.07.2022..
//

import UIKit
import SnapKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CustomCollectionViewCell"
    
    private enum Constants {                                                
        static let contentViewCornerRadius: CGFloat = 10
        static let imageHeight: CGFloat = 50
        static let padding: CGFloat = 10
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .systemRed
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()                                               // view = private layz var
        
        label.numberOfLines = 10
        label.textAlignment = .natural
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        
        contentView.addSubview(imageView)
        contentView.addSubview(name)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupLayouts() {
        
        contentView.backgroundColor = .tertiarySystemGroupedBackground
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.imageHeight)
            make.left.equalToSuperview().offset(Constants.padding)
            make.top.equalToSuperview().offset(Constants.padding)
        }
        
        name.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(Constants.padding)
            make.right.equalToSuperview().offset(-Constants.padding)
            make.centerY.equalTo(imageView.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constants.padding)
            make.right.bottom.equalToSuperview().offset(-Constants.padding)
            make.top.equalTo(imageView.snp_bottomMargin).offset(1.5*Constants.padding) // medium padding tu
        }

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
        imageView.image = data.image
        name.text = data.title
        descriptionLabel.text = data.description
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        descriptionLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
}
