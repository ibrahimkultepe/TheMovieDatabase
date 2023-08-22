//
//  MainHeaderCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 21.08.2023.
//

public class MainHeaderCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: MainCellModelProtocol?
    
    private let imageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .build()
    
    private let titleLabel = UILabelBuilder()
        .textColor(.appWhite)
        .font(.font(.nunitoExtraBold, size: .custom(size: 18)))
        .build()
    
    private let descriptionLabel = UILabelBuilder()
        .textColor(.appWhite)
        .font(.font(.nunitoBold, size: .xLarge))
        .numberOfLines(2)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension MainHeaderCell {
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview()
        
        contentView.addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .init(top: 140, left: 20, bottom: 0, right: 20))
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.topToBottom(of: titleLabel).constant = 5
        descriptionLabel.edgesToSuperview(excluding: [.top, .bottom], insets: .left(20) + .right(20))
    }
}

//MARK: - SetCellItem
public extension MainHeaderCell {
    
    func setCellItem(viewModel: MainCellModelProtocol) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.imageView.image = viewModel.image
    }
}
