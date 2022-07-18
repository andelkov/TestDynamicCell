//
//  CustomCollectionViewCelle.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 13.07.2022..
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(myLabel)
        contentView.addSubview(myImageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect(x: 5, y: contentView.frame.size.height-50, width: contentView.frame.size.width-10, height: 50)
        myImageView.frame = CGRect(x:5, y:0, width: contentView.frame.size.width-10, height: contentView.frame.size.height-50)
    }
    
    public func configure(label: String, image: UIImage) {
        // make load according to MVVM
        myLabel.text = label
        myImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
        myImageView.image = nil
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
