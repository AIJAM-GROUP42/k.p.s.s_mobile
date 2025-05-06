//
//  LoadingView.swift
//  k.p.s.s_mobile
//
//  Created by iremt on 6.05.2025.
//


import UIKit

final class LoadingView: UIView {

    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "dusunme"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "🧠 Beyno düşünüyor..."
        label.font = .italicSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        layer.cornerRadius = 12
        setupUI()
        startRotation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.translatesAutoresizingMaskIntoConstraints = false

        addSubview(container)
        container.addSubview(imageView)
        container.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalToConstant: 200),
            container.heightAnchor.constraint(equalToConstant: 220),

            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12)
        ])
    }

    private func startRotation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2.0
        rotation.repeatCount = .infinity
        imageView.layer.add(rotation, forKey: "rotationAnimation")
    }

    func show(in view: UIView) {
        frame = view.bounds
        view.addSubview(self)
    }

    func hide() {
        removeFromSuperview()
    }
}
