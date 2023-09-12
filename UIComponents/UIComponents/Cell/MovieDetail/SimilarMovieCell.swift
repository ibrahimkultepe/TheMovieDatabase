//
//  SimilarMovieCell.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 4.09.2023.
//

public class SimilarMovieCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: SimilarMovieCellModelProtocol?
    
    private let imageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .cornerRadius(15)
        .clipsToBounds(true)
        .build()
    
    private let titleLabel = UILabelBuilder()
        .textColor(.black)
        .font(.font(.nunitoBold, size: .xxLarge))
        .numberOfLines(0)
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
extension SimilarMovieCell {
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        imageView.edgesToSuperview(excluding: .bottom)
        imageView.height(100)
        
        contentView.addSubview(titleLabel)
        titleLabel.topToBottom(of: imageView).constant = 10
        titleLabel.edgesToSuperview(excluding: .top)
    }
}

//MARK: - SetCellItem
public extension SimilarMovieCell {
    
    func setCellItem(viewModel: SimilarMovieCellModelProtocol) {
        self.viewModel = viewModel
        imageView.setImage(viewModel.backdropPath)
        titleLabel.text = viewModel.title
    }
}
