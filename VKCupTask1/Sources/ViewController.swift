//
//  ViewController.swift
//  VKCupTask1
//
//  Created by Артем Галай on 5.12.22.
//

import UIKit

final class ViewController: UIViewController {
    
    var isTap = true

    private var categories = Categories.names

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
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.dragInteractionEnabled = true
        collectionView.dropDelegate = self
        collectionView.dragDelegate = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarhy()
        setupLayout()
    }

    private func setupHierarhy() {
        view.addSubview(titleLabel)
        view.addSubview(skipButton)
        view.addSubview(collectionView)
    }

    private func setupLayout() {
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

    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath {

            collectionView.performBatchUpdates({
                categories.remove(at: sourceIndexPath.item)
                categories.insert(item.dragItem.localObject as? String ?? "no item",
                                  at: destinationIndexPath.item)

                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier,
                                                            for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 12
        cell.backgroundColor = .separator
        cell.titleLabel.text = categories[indexPath.row]
        cell.titleLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
}

extension ViewController: UICollectionViewDragDelegate {

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = categories[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension ViewController: UICollectionViewDropDelegate {

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {

        var destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }

        if coordinator.proposal.operation == .move {
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
    }
}

extension ViewController: UICollectionViewDelegate {



    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell

                if isTap {
                    print("True")
                    cell?.separatorView.isHidden = true
                    cell?.backgroundColor = .orange
                    cell?.plusImage.image = UIImage(systemName: "checkmark")
                    isTap = false
                } else {
                    print("False")
                    isTap = true
                    cell?.separatorView.isHidden = false
                    cell?.backgroundColor = .separator
                    cell?.plusImage.image = UIImage(systemName: "plus")
                }
//        print("Hello")
//        cell?.separatorView.isHidden = true
//        cell?.backgroundColor = .orange
//        cell?.plusImage.image = UIImage(systemName: "checkmark")
    }
}
