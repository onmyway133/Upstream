import UIKit

/// Section
public struct Section<T> {
  public let header: Header<T>?
  public let items: [Item<T>]
  public let footer: Footer<T>?

  public init(header: Header<T>? = nil, items: [Item<T>], footer: Footer<T>? = nil) {
    self.header = header
    self.items = items
    self.footer = footer
  }
}
