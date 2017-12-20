//
//  ViewController.swift
//  CollectionLayouts
//
//  Created by Alex Antonyuk on 11/15/17.
//  Copyright © 2017 Alex Antonyuk. All rights reserved.
//

import UIKit
import SnapKit

struct Data {
	let title: String
	let image: UIImage
}

protocol DataCell: class {
	var data: Data? { get set }
}

final class ViewController: UIViewController {

	private var collectionView: UICollectionView!
	private var layout: CustomLayout!
	private var layout2: CustomLayout!

	let data: [Data] = [
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1")),
		Data(title: "Test", image: #imageLiteral(resourceName: "1"))
	]

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(onToggleTap(_:)))
		setupUI()
	}

	@objc private func onToggleTap(_ sender: UIBarButtonItem) {
		collectionView.collectionViewLayout.invalidateLayout()
		if collectionView.collectionViewLayout == layout {
			collectionView.setCollectionViewLayout(layout2, animated: false)
		} else {
			collectionView.setCollectionViewLayout(layout, animated: false)
		}
	}

	private func setupUI() {
		view.backgroundColor = .white
		
		layout = CustomLayout(style: .grid(height: 180.0, columns: 2))
		layout2 = CustomLayout(style: .list(height: 100.0))

		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.backgroundColor = #colorLiteral(red: 0.2901960909, green: 0.5647059083, blue: 0.886274457, alpha: 1)

		collectionView.register(UINib.init(nibName: "GridCell", bundle: nil), forCellWithReuseIdentifier: "GridCell")
		collectionView.register(UINib.init(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: "ListCell")
		collectionView.register(UniversalCell.self, forCellWithReuseIdentifier: "UniversalCell")
		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return data.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let layout = collectionView.collectionViewLayout as! CustomLayout
		print("cell \(layout.cellIdentifier)")
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UniversalCell", for: indexPath) as! (DataCell & UICollectionViewCell)
		cell.data = data[indexPath.row]
		return cell
	}
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected \(indexPath) \(data[indexPath.row])")
    }
}
