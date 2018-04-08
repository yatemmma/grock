const Base = require("../../core/models/base")

class Image extends Base {
  static props() {
    return {
      url: String
    }
  }
}

module.exports = Image
