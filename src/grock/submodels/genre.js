const Base = require("../../core/models/base")

class Genre extends Base {
  static props() {
    return {
      code: String
    }
  }
}

module.exports = Genre
