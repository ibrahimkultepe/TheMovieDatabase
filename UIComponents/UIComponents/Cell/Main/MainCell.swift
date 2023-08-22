//
//  MainCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.08.2023.
//

public class MainCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: MainCellModelProtocol?
    
    private let imageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .cornerRadius(15)
        .clipsToBounds(true)
        .build()
    
    private let titleLabel = UILabelBuilder()
        .textColor(.black)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let descriptionLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoBold, size: .xLarge))
        .numberOfLines(2)
        .build()
    
    private let titleAndDescriptionStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(7)
        .build()
    
    private let dateLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoBold, size: .xLarge))
        .textAlignment(.right)
        .build()
    
    private let chevronImageView = UIImageViewBuilder()
        .contentMode(.scaleAspectFit)
        .build()
    
    private let seperator = UIViewBuilder()
        .backgroundColor(.appZircon)
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
extension MainCell {
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview(excluding: .right, insets: .init(top: 20, left: 20, bottom: 20, right: 0))
        imageView.width(125)
        
        contentView.addSubview(titleAndDescriptionStackView)
        titleAndDescriptionStackView.leadingToTrailing(of: imageView).constant = 10
        titleAndDescriptionStackView.edgesToSuperview(excluding: [.left, .bottom], insets: .top(30) + .right(40))
        titleAndDescriptionStackView.addArrangedSubview(titleLabel)
        titleAndDescriptionStackView.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(dateLabel)
        dateLabel.leadingToTrailing(of: imageView)
        dateLabel.edgesToSuperview(excluding: [.top, .left] ,insets: .init(top: 0, left: 0, bottom: 20, right: 30))
        
        contentView.addSubview(chevronImageView)
        chevronImageView.size(.init(width: 5, height: 10))
        chevronImageView.leadingToTrailing(of: dateLabel).constant = 5
        chevronImageView.image = .icChevron
        chevronImageView.trailingToSuperview().constant = -20
        chevronImageView.centerYToSuperview()
        
        contentView.addSubview(seperator)
        seperator.bottomToSuperview()
        seperator.edgesToSuperview(excluding: [.top, .bottom])
        seperator.height(1)
    }
}

//MARK: - SetCellItem
public extension MainCell {
    
    func setCellItem(viewModel: MainCellModelProtocol) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.imageView.image = viewModel.image
        self.dateLabel.text = viewModel.date
    }
}
