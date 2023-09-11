//
//  MovieDetailViewController.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 2.09.2023.
//

final class MovieDetailViewController: BaseViewController<MovieDetailViewModel> {
    
    private let scrollView = UIScrollViewBuilder()
        .build()
    
    private let contentView = UIViewBuilder()
        .build()
    
    private let contentStackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let movieImageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .build()
    
    private let ratingAndDateView = UIViewBuilder()
        .build()
    
    private let ratingAndDateStackView = UIStackViewBuilder()
        .spacing(10)
        .axis(.horizontal)
        .alignment(.center)
        .build()
    
    private let imdbImageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .image(.imgImdb)
        .build()
    
    private let starImageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .image(.imgFilledStar)
        .build()
    
    private let movieRatingLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let movieTopRatingLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let yellowCircleImageView = UIImageViewBuilder()
        .contentMode(.scaleToFill)
        .image(.imgYellowCircle)
        .build()
    
    private let movieDateLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let movieInfoStackView = UIStackViewBuilder()
        .spacing(10)
        .axis(.vertical)
        .build()
    
    private let movieTitleLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoBold, size: .custom(size: 20)))
        .build()
    
    private let movieOverviewLabel = UILabelBuilder()
        .textColor(.appRaven)
        .font(.font(.nunitoBold, size: .xxLarge))
        .numberOfLines(0)
        .build()
    
    private let similarStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(10)
        .build()
    
    private let similarMoviesLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoBold, size: .xxLarge))
        .build()
    
    private let similarMoviesCollectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .scrollDirection(.horizontal)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContent()
        setLocalize()
        subcribeViewModel()
        viewModel.getMovieDetail()
        viewModel.getMovieSimilar()
    }
}

// MARK: - UILayout
extension MovieDetailViewController {
    
    private func addSubviews() {
        addMovieImageView()
        addScrollView()
        addContentStackView()
        addSimilarStackView()
    }
    
    private func addMovieImageView() {
        view.addSubview(movieImageView)
        movieImageView.edgesToSuperview(excluding: .bottom, usingSafeArea: false)
        movieImageView.aspectRatio(1)
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.topToBottom(of: movieImageView)
        scrollView.edgesToSuperview(excluding: [.bottom, .top], usingSafeArea: true)
        
        scrollView.addSubview(contentView)
        contentView.edgesToSuperview()
        contentView.widthToSuperview()
        
        contentView.addSubview(contentStackView)
        contentStackView.edgesToSuperview(insets: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    private func addContentStackView() {
        contentStackView.addArrangedSubview(ratingAndDateView)
        ratingAndDateView.addSubview(ratingAndDateStackView)
        ratingAndDateStackView.edgesToSuperview(excluding: .right)
        
        ratingAndDateStackView.addArrangedSubview(imdbImageView)
        imdbImageView.size(.init(width: 48, height: 48))
        
        ratingAndDateStackView.addArrangedSubview(starImageView)
        starImageView.size(.init(width: 24, height: 24))
        
        ratingAndDateStackView.addArrangedSubview(movieRatingLabel)
        ratingAndDateStackView.setCustomSpacing(0, after: movieRatingLabel)
        
        ratingAndDateStackView.addArrangedSubview(movieTopRatingLabel)
        
        ratingAndDateStackView.addArrangedSubview(yellowCircleImageView)
        yellowCircleImageView.size(.init(width: 6, height: 6))
        
        ratingAndDateStackView.addArrangedSubview(movieDateLabel)
        ratingAndDateStackView.setCustomSpacing(10, after: movieDateLabel)
        
        contentStackView.addArrangedSubview(movieInfoStackView)
        
        movieInfoStackView.addArrangedSubview(movieTitleLabel)
        movieInfoStackView.addArrangedSubview(movieOverviewLabel)
    }
    
    private func addSimilarStackView() {
        view.addSubview(similarStackView)
        similarStackView.topToBottom(of: scrollView).constant = 10
        similarStackView.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 20, bottom: 0, right: 20), usingSafeArea: true)
        similarStackView.addArrangedSubview(similarMoviesLabel)
        similarStackView.addArrangedSubview(similarMoviesCollectionView)
        similarMoviesCollectionView.height(160)
    }
}

// MARK: - ConfigureContent
extension MovieDetailViewController {
    
    private func configureContent() {
        similarMoviesCollectionView.dataSource = self
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.register(SimilarMovieCell.self)
    }
    
    private func setItem() {
        movieImageView.setImage(viewModel.backdropPath)
        movieRatingLabel.text = viewModel.movieRating
        movieDateLabel.text = viewModel.date
        movieTitleLabel.text = viewModel.title
        movieOverviewLabel.text = viewModel.overview
    }
    
    private func updateStarImage() {
        guard let star = viewModel.starRating else { return }
        if star >= 6.5 {
            starImageView.image = .imgFilledStar
        } else {
            starImageView.image = .imgNotFilledStar
        }
    }
    
    private func setEmptyMovieImage() {
        if viewModel.backdropPath == nil {
            movieImageView.image = .imgEmptyMovie
        }
    }
    
    private func setSimilarMoviesLabelHiddenStatus() {
        if viewModel.cellItems.isEmpty {
            similarMoviesLabel.isHidden = true
        }
    }
}

// MARK: - SetLocalize
extension MovieDetailViewController {
    
    private func setLocalize() {
        movieTopRatingLabel.text = L10n.MovieDetail.movieTopRatingLabelText
        similarMoviesLabel.text = L10n.MovieDetail.similarMoviesLabelText
    }
}

// MARK: - UICollectionViewDelegate
extension MovieDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectMovieDetail(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SimilarMovieCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemForAt(indexPath: indexPath)
        cell.setCellItem(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - SubscribeViewModel
extension MovieDetailViewController {
    
    private func subcribeViewModel() {
        viewModel.getDataDidSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setItem()
                self.similarMoviesCollectionView.reloadData()
                self.setSimilarMoviesLabelHiddenStatus()
                self.updateStarImage()
                self.setEmptyMovieImage()
            }
        }
    }
}
