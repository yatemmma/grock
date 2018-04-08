const Base = require("../../core/models/base")
const SubModels = require("./submodels/submodels")

class Band extends Base {
  static props() {
    return {
      code: String,
      name: SubModels.Name
    }
  }
}

module.exports = Band
