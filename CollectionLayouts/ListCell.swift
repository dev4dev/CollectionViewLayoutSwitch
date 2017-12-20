//
//  ListCell.swift
//  CollectionLayouts
//
//  Created by Alex Antonyuk on 11/15/17.
//  Copyright © 2017 Alex Antonyuk. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell, DataCell {

	var data: Data? {
		didSet {
			guard let data = data else { return }

			imageView.image = data.image
			label.text = data.title
		}
	}

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var label: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()

		layer.cornerRadius = 5.0
	}
}
