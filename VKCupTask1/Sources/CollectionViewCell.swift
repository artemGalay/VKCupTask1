//
//  CollectionViewCell.swift
//  VKCupTask1
//
//  Created by Артем Галай on 6.12.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = "CollectionViewCell"

//    var isTap = true

    let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .separator
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFPro-Semibold", size: 16)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let plusImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.27)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(plusImage)
        addSubview(separatorView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            titleLabel.trailingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: -10),

            separatorView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            separatorView.widthAnchor.constraint(equalToConstant: 1),

            plusImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            plusImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            plusImage.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 10),
            plusImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    @objc func viewTupped() {
//        if isTap {
//            print("True")
//            separatorView.isHidden = true
//            mainView.backgroundColor = .orange
//            plusImage.image = UIImage(systemName: "checkmark")
//            isTap = false
//        } else {
//            print("False")
//            isTap = true
//            separatorView.isHidden = false
//            mainView.backgroundColor = .separator
//            plusImage.image = UIImage(systemName: "plus")
//        }
    }
}
