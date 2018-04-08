class LinkHelper {
  static link(level = 0) {
    return (path)=>{
      return `./${"../".repeat(level)}${path}`
    }
  }
}

module.exports = LinkHelper
