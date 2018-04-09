import UIKit

/// Section header
public struct Header {
  let model: Any
  let viewType: UIView.Type

  public init(model: Any, viewType: UIView.Type) {
    self.model = model
    self.viewType = viewType
  }
}
