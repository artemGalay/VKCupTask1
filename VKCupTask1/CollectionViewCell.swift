//
//  CollectionViewCell.swift
//  VKCupTask1
//
//  Created by Артем Галай on 6.12.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = "CollectionViewCell"

    var isTap = true

    let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
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





    override init(frame: CGRect) {
        super.init(frame: frame)
//        addSubview(mainView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTupped))
        mainView.addGestureRecognizer(gesture)
        mainView.addSubview(titleLabel)
        mainView.addSubview(plusImage)
        contentView.addSubview(mainView)
        setupLayout()

        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {

        NSLayoutConstraint.activate([

            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 9),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -11),
//            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -55),

            plusImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 11),
            plusImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -11),
            plusImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 26),
            plusImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -11)
        ])
    }

    @objc func viewTupped() {
        if isTap {
            print("True")
            mainView.backgroundColor = .orange
            plusImage.image = UIImage(systemName: "checkmark")
            isTap = false
        } else {
            print("False")
            isTap = true
            mainView.backgroundColor = .separator
            plusImage.image = UIImage(systemName: "plus")
        }
    }
}
