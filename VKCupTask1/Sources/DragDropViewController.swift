//
//  DragDropViewController.swift
//  VKCupTask1
//
//  Created by Артем Галай on 16.12.22.
//

import UIKit

final class DragDropViewController: UIViewController {

    //MARK: Private Properties

    private var categories = Categories.names

    private var favoriteCategories = [String]()

    //MARK: Outlets

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

    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = TagFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DragDropCollectionViewCell.self, forCellWithReuseIdentifier: DragDropCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.dragInteractionEnabled = true
        collectionView.dropDelegate = self
        collectionView.dragDelegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    private lazy var favoriteCategoriesCollectionView: UICollectionView = {
        let layout = TagFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DragDropCollectionViewCell.self, forCellWithReuseIdentifier: DragDropCollectionViewCell.identifier)
        collectionView.backgroundView = backgroundImage
        collectionView.layer.cornerRadius = 12
        collectionView.dataSource = self
        collectionView.dragInteractionEnabled = true
        collectionView.dropDelegate = self
        collectionView.dragDelegate = self
        collectionView.reorderingCadence = .fast
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    //MARK: View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(skipButton)
        view.addSubview(categoriesCollectionView)
        view.addSubview(favoriteCategoriesCollectionView)
        setupLayout()
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

            categoriesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 300),

            favoriteCategoriesCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 10),
            favoriteCategoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            favoriteCategoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            favoriteCategoriesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    //MARK: Private Methods

    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath {
            var indexPath = destinationIndexPath
            if indexPath.row >= collectionView.numberOfItems(inSection: 0) {
                indexPath.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
                if collectionView === favoriteCategoriesCollectionView {
                    self.favoriteCategories.remove(at: sourceIndexPath.row)
                    self.favoriteCategories.insert(item.dragItem.localObject as? String ?? "no item", at: indexPath.row)
                } else {
                    self.categories.remove(at: sourceIndexPath.row)
                    self.categories.insert(item.dragItem.localObject as? String ?? "no item", at: indexPath.row)
                }
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [indexPath])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: indexPath)
        }
    }

    private func copyItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        collectionView.performBatchUpdates({
            var indexPaths = [IndexPath]()
            for (index, item) in coordinator.items.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                if collectionView === favoriteCategoriesCollectionView {
                    self.favoriteCategories.insert(item.dragItem.localObject as? String ?? "no item", at: indexPath.row)
                } else {
                    self.categories.insert(item.dragItem.localObject as? String ?? "no item", at: indexPath.row)
                }
                indexPaths.append(indexPath)
            }
            collectionView.insertItems(at: indexPaths)
        })
    }
}

// MARK: - UICollectionViewDataSource Methods
extension DragDropViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.categoriesCollectionView ? self.categories.count : self.favoriteCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoriesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DragDropCollectionViewCell.identifier, for: indexPath) as? DragDropCollectionViewCell else { return UICollectionViewCell()}
            cell.backgroundColor = .separator
            cell.layer.cornerRadius = 12
            cell.titleLabel.text = self.categories[indexPath.row]
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DragDropCollectionViewCell.identifier, for: indexPath) as? DragDropCollectionViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .orange
            cell.layer.cornerRadius = 12
            cell.plusImage.image = UIImage(systemName: "checkmark")
            cell.separatorView.isHidden = true
            cell.titleLabel.text = self.favoriteCategories[indexPath.row]
            return cell
        }
    }
}

// MARK: - UICollectionViewDragDelegate Methods
extension DragDropViewController : UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = collectionView == categoriesCollectionView ? self.categories[indexPath.row] : self.favoriteCategories[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let item = collectionView == categoriesCollectionView ? self.categories[indexPath.row] : self.favoriteCategories[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

// MARK: - UICollectionViewDropDelegate Methods
extension DragDropViewController : UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView === self.categoriesCollectionView {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            } else {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
        } else {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            } else {
                return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        switch coordinator.proposal.operation {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
        case .copy:
            self.copyItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        default:
            return
        }
    }
}
