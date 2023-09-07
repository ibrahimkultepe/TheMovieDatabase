// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Base {
    /// Try Again
    public static let errorButtonTitle = L10n.tr("Modules", "Base.errorButtonTitle")
  }

  public enum Home {
    /// Search
    public static let searchControllerText = L10n.tr("Modules", "Home.searchControllerText")
  }

  public enum MovieDetail {
    /// /10
    public static let movieTopRatingLabelText = L10n.tr("Modules", "MovieDetail.movieTopRatingLabelText")
    /// Benzer Filmler
    public static let similarMoviesLabelText = L10n.tr("Modules", "MovieDetail.similarMoviesLabelText")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
