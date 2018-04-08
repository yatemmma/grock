const Base = require("../../../core/models/base")

class Link extends Base {
  static props() {
    return {
      name: String
    }
  }
}

module.exports = Link
