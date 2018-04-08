const Base = require("../../core/models/base")

class Origin extends Base {
  static props() {
    return {
      code: String,
      description: String
    }
  }
}

module.exports = Origin
