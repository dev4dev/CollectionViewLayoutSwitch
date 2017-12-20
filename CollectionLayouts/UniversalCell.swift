//
//  UniversalCell.swift
//  CollectionLayouts
//
//  Created by Alex Antonyuk on 11/15/17.
//  Copyright © 2017 Alex Antonyuk. All rights reserved.
//

import UIKit
import SnapKit

class UniversalCell: UICollectionViewCell, DataCell {
	var data: Data? {
		didSet {
			guard let data = data else { return }

			imageView.image = data.image
			label.text = data.title
		}
	}

	var imageView: UIImageView!
	var label: UILabel!
	var stack: UIStackView!

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.layer.cornerRadius = 5.0
		contentView.backgroundColor = .white
		contentView.clipsToBounds = true

		stack = UIStackView()
		stack.alignment = .center
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 16.0
		contentView.addSubview(stack)
		stack.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(16.0)
		}

		imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		stack.addArrangedSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.width.equalTo(imageView.snp.height)
		}

		label = UILabel()
		label.setContentCompressionResistancePriority(.required, for: .vertical)
		stack.addArrangedSubview(label)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
		guard let l = newLayout as? StyledLayout else { return }


		switch l.style {
		case .list(height: _):
			self.makeList()
		case .grid(height: _, columns: _):
			self.makeGrid()
		}
	}

	private func makeList() {
		stack.axis = .horizontal
	}

	private func makeGrid() {
		stack.axis = .vertical
	}
}
