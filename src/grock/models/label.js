const Base = require("../../core/models/base")
const Band = require("./band.js")
const SubModels = require("./submodels/submodels")

class Label extends Base {
  static props() {
    return {
      code:    String,
      name:    SubModels.Name,
      origin:  SubModels.Origin,
      images:  [SubModels.Image],
      genres:  [SubModels.Genre],
      bands:   [Band],
      website: SubModels.Link,
      youtube: SubModels.Link
    }
  }
}

module.exports = Label
