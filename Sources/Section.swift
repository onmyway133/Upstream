import UIKit

/// Section
public struct Section<T> {
  let header: Header<T>?
  let items: [Item<T>]
  let footer: Footer<T>?

  public init(header: Header<T>? = nil, items: [Item<T>], footer: Footer<T>? = nil) {
    self.header = header
    self.items = items
    self.footer = footer
  }
}
