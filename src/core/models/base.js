class Base {
  static props() {
    return {}
  }

  static setData(key, data) {
    Base[key] = data
  }

  static getData(key) {
    return Base[key]
  }

  constructor(raw = {}) {
    this.data = {}
    const props = this.constructor.props()
    Object.keys(props).forEach((key)=>{
      const clazz = props[key]
      if (clazz == String) {
        this.data[key] = raw[key]
      } else if (clazz.constructor.name == "Array") {
        const clazz2 = clazz[0]
        this.data[key] = (raw[key] || []).map((data)=>{
          if (clazz2 == String) {
            return data
          } else {
            return new clazz2(data)
          }
        })
      } else {
        this.data[key] = new clazz(raw[key])
      }
    })
  }

  toJSON() {
    const json = {}
    const props = this.constructor.props()

    Object.keys(props).forEach((key)=>{
      const clazz = props[key]
      if (clazz == String) {
        json[key] = this.data[key]
      } else if (clazz.constructor.name == "Array") {
        const clazz2 = clazz[0]
        json[key] = this.data[key].map((data)=>{
          if (clazz2 == String) {
            return data
          } else {
            return data.toJSON()
          }
        })
      } else {
        json[key] = this.data[key].toJSON()
      }
    })

    return json
  }
}

module.exports = Base
