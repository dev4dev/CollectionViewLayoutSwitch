//
//  GridLayout.swift
//  CollectionLayouts
//
//  Created by Alex Antonyuk on 11/15/17.
//  Copyright © 2017 Alex Antonyuk. All rights reserved.
//

import UIKit

enum Style {
	case list(height: CGFloat)
	case grid(height: CGFloat, columns: Int)
}

protocol StyledLayout: class {
	var style: Style { get set }
}

final class CustomLayout: UICollectionViewFlowLayout, StyledLayout {
	var style: Style

	override var itemSize: CGSize {
		get {
			guard let cv = collectionView else { return .zero}
			let parentWidth = cv.bounds.width - (sectionInset.left + sectionInset.right)

			switch style {
			case let .list(height):
				return CGSize(width: parentWidth, height: height)
			case let .grid(height, columns):
				let width = (parentWidth / CGFloat(columns)) - minimumInteritemSpacing
				return CGSize(width: width, height: height)
			}
		}
		set {
			super.itemSize = newValue
		}
	}

	init(style: Style) {
		self.style = style

		super.init()

		minimumInteritemSpacing = 3.0
		minimumLineSpacing = 3.0
		sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	var cellIdentifier: String {
		switch style {
		case .list(height: _):
			return "ListCell"
		case .grid(height: _, columns: _):
			return "GridCell"
		}
	}
}
