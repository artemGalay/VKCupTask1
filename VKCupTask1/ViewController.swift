//
//  ViewController.swift
//  VKCupTask1
//
//  Created by Артем Галай on 5.12.22.
//

import UIKit

class ViewController: UIViewController {

    private var selected = [String]()
    private var titles = ["Юморdvfdbdfgbfdbdggbdgbfdb", "Еда", "Кино", "Рестораны", "Прогулки", "Политика", "Новости", "Автомобили", "Сериалы", "Рецепты", "Работа", "Отдых", "Спорт", "Политика", "Новости", "Юмор", "Еда", "Кино", "Рестораны", "Прогулки", "Политика", "Новости", "Юмор", "Еда", "Кино"  ]

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.48)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFPro-Regular", size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: "Отметьте то, что вам интересно, чтобы настроить Дзен",
                                                         attributes: [NSAttributedString.Key.kern: -0.31,
                                                                      NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()

    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Позже", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12).cgColor
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = TagFlowLayout()
//        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        collectionView.collectionViewLayout = layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarhy()
        setuoLayout()
    }

    private func setupHierarhy() {
        view.addSubview(titleLabel)
        view.addSubview(skipButton)
        view.addSubview(collectionView)
    }

    private func setuoLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 43),
            titleLabel.widthAnchor.constraint(equalToConstant: 252),

            skipButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skipButton.heightAnchor.constraint(equalToConstant: 43),
            skipButton.widthAnchor.constraint(equalToConstant: 79),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier,
                                                            for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = titles[indexPath.row]
        cell.titleLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16

        return cell

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 200, height: 30)
//    }


}
