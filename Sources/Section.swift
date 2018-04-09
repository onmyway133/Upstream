import UIKit

/// Section
public struct Section {
  public let header: Header?
  public let items: [Item]
  public let footer: Footer?

  public init(header: Header? = nil, items: [Item], footer: Footer? = nil) {
    self.header = header
    self.items = items
    self.footer = footer
  }
}
