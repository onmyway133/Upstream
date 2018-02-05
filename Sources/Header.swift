import UIKit

/// Section header
public struct Header<T> {
  let model: T
  let viewType: UIView.Type

  public init(model: T, viewType: UIView.Type) {
    self.model = model
    self.viewType = viewType
  }
}
