const Base = require("../../../core/models/base")

class Name extends Base {
  static props() {
    return {
      name: String
    }
  }
}

module.exports = Name
