//
//  CollectionViewCell.swift
//  VKCupTask1
//
//  Created by Артем Галай on 6.12.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = "CollectionViewCell"

//    let mainView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 20
//        view.backgroundColor = .separator
//        view.sizeToFit()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.contentMode = .scaleToFill
//        label.font = .systemFont(ofSize: 12)
        label.textColor = .red
        label.textAlignment = .left
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        addSubview(mainView)
        contentView.addSubview(titleLabel)
        setupLayout()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
      ) -> UICollectionViewLayoutAttributes
      {
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)

        let fittingSize = UIView.layoutFittingCompressedSize

        layoutAttributes.frame.size = systemLayoutSizeFitting(
          fittingSize,
          withHorizontalFittingPriority: .fittingSizeLevel,
          verticalFittingPriority: .fittingSizeLevel
        )

        return layoutAttributes
      }


//
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//           titleLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
//           layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//           return layoutAttributes
//       }

    private func setupLayout() {
        NSLayoutConstraint.activate([

//            mainView.topAnchor.constraint(equalTo: topAnchor),
//            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            titleLabel.heightAnchor.constraint(equalToConstant: 40),
//            titleLabel.widthAnchor.constraint(equalToConstant: 100)
        ])

//        titleLabel.setContentHuggingPriority(UILayoutPriority(750), for: .horizontal)
    }

}
