//
//  SearchCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 28.08.2023.
//

public class SearchCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: SearchCellModelProtocol?
    
    private let titleLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let dateLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let labelStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(5)
        .build()
    
    private let iconImageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .image(.icSearch)
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
extension SearchCell {
    
    private func addSubviews() {
        contentView.addSubview(iconImageView)
        iconImageView.leadingToSuperview().constant = 10
        iconImageView.centerYToSuperview()
        iconImageView.size(.init(width: 20, height: 20))
        
        contentView.addSubview(labelStackView)
        labelStackView.leadingToTrailing(of: iconImageView).constant = 10
        labelStackView.centerYToSuperview()
        labelStackView.trailingToSuperview().constant = -10
        labelStackView.addArrangedSubview(titleLabel)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelStackView.addArrangedSubview(dateLabel)
        dateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        contentView.addSubview(seperator)
        seperator.edgesToSuperview(excluding: .top)
        seperator.height(1)
    }
}

//MARK: - SetCellItem
public extension SearchCell {
    
    func setCellItem(viewModel: SearchCellModelProtocol) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
    }
}
