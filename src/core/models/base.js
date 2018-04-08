class Base {
  static props() {
    return {}
  }

  constructor(raw) {
    this.raw = raw
  }

  toJSON() {
    const json = {}
    const props = this.constructor.props()

    Object.keys(props).forEach((key)=>{
      const clazz = props[key]
      if (clazz == String) {
        json[key] = this.raw[key]
      } else if (clazz.constructor.name == "Array") {
        const clazz2 = clazz[0]
        json[key] = this.raw[key].map((data)=>{
          if (clazz2 == String) {
            return data
          } else {
            return data.toJSON()
          }
        })
      } else {
        json[key] = new clazz(this.raw[key]).toJSON()
      }
    })

    return json
  }
}

module.exports = Base
