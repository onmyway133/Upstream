import UIKit

/// Section footer
public struct Footer<T> {
  let model: T
  let viewType: UIView.Type

  public init(model: T, viewType: UIView.Type) {
    self.model = model
    self.viewType = viewType
  }
}
