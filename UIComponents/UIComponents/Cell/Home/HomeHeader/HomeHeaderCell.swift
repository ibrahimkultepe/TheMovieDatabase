//
//  HomeHeaderCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 21.08.2023.
//

public class HomeHeaderCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: HomeHeaderCellModelProtocol?
    
    private let imageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .clipsToBounds(true)
        .build()
    
    private let titleLabel = UILabelBuilder()
        .textColor(.appWhite)
        .font(.font(.nunitoExtraBold, size: .custom(size: 18)))
        .build()
    
    private let overviewLabel = UILabelBuilder()
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
extension HomeHeaderCell {
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview()
        
        contentView.addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: [.bottom, .top], insets: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        contentView.addSubview(overviewLabel)
        overviewLabel.topToBottom(of: titleLabel).constant = 5
        overviewLabel.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 20, bottom: 30, right: 20))
    }
}

//MARK: - SetCellItem
public extension HomeHeaderCell {

    func setCellItem(viewModel: HomeHeaderCellModelProtocol) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        overviewLabel.text = viewModel.overview
        imageView.setImage(L10n.General.posterPathBaseURL + (viewModel.posterPath ?? ""))
    }
}
