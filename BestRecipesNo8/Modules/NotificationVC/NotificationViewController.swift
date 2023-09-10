//
//  NotificationViewController.swift
//  BestRecipesNo8
//
//  Created by Келлер Дмитрий on 02.09.2023.
//

import UIKit

class MainV: UIView {
    private lazy var backgroundView: UIImageView = {
        let imageViewBackground = UIImageView(frame: UIScreen.main.bounds)
        imageViewBackground.image = UIImage(named: "Vladimir")
        imageViewBackground.contentMode = .scaleAspectFit
        return imageViewBackground
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
