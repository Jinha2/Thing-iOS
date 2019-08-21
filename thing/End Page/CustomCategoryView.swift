//
//  CustomCategoryView.swift
//  thing
//
//  Created by 이호찬 on 21/08/2019.
//  Copyright © 2019 mashup. All rights reserved.
//
// 스토리보드가 넘 느리고, 시간도 많지 않아서 급하게 코드로 짭니다.... 혹시 불편하시다면 추후 인터페이스빌더로 수정하도록 하겠습니다.

import UIKit

class CustomCategoryView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.spacing = 5
        stackView.alignment = .fill

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        translatesAutoresizingMaskIntoConstraints = false
        setLayout()
    }
}

extension CustomCategoryView {
    private func setLayout() {

        heightAnchor.constraint(equalToConstant: 20)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CustomCategoryView {
    private func makeLabel(title: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = textColor
        label.font = .systemFont(ofSize: 14, weight: .medium)

        return label
    }

    private func makeDot(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.alpha = 0.3
        view.clipsToBounds = true
        view.cornerRadius = 2.5

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension CustomCategoryView {
    func setCategory(categorys: [String], color: UIColor) {
        if !stackView.arrangedSubviews.isEmpty { return }

        var stackArray = [UIView]()
        var dotViews = [UIView]()
        categorys.enumerated().forEach { index, title in
            if index != 0 {
                let dotView = makeDot(color: color)
                stackArray.append(dotView)
                dotViews.append(dotView)
            }
            stackArray.append(makeLabel(title: title, textColor: color))
        }
        stackArray.forEach {
            stackView.addArrangedSubview($0)
        }
        dotViews.forEach {

            let a = $0.widthAnchor.constraint(equalToConstant: 5)
//            a.priority = UILayoutPriority(rawValue: 750)
            a.isActive = true
            let b = $0.heightAnchor.constraint(equalTo: widthAnchor)
//            b.priority = UILayoutPriority(rawValue: 750)
            b.isActive = true
        }
    }
}
