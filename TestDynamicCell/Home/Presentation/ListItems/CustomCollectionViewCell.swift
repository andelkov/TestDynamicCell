//
//  CustomCollectionViewCelle.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 13.07.2022..
//

import UIKit
import SnapKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private enum Constants {                                                //gdje ovo ostaviti
        static let contentViewCornerRadius: CGFloat = 10
        static let imageHeight: CGFloat = 50
        static let padding: CGFloat = 10
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textAlignment = .justified
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
            make.left.equalTo(contentView.snp.left).offset(Constants.padding)
            make.top.equalTo(contentView.snp.top).offset(Constants.padding)
        }
        
        name.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp_rightMargin).offset(1.5*Constants.padding)
            make.centerY.equalTo(imageView.snp.centerY)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(Constants.padding)
            make.right.bottom.equalTo(contentView).offset(-Constants.padding)
            make.top.equalTo(imageView.snp_bottomMargin).offset(1.5*Constants.padding)
        }

    }
    
    func setup(with framework: Framework) {
        imageView.image = UIImage(named: framework.imageName)
        name.text = framework.name
        descriptionLabel.text = framework.description
    }
}

extension CustomCollectionViewCell: Configurable {
    
    func configure(with data: Data) {
    }
    
    struct Data {
        let title: String
        let description: String
        let image: UIImage?
        let url: URL?
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        descriptionLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
}
