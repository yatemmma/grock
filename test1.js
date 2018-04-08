'use strict'

const a = {
  "hoge1": "test1",
  "hoge2": {
    "sub1": "test2",
    "sub2": {
      "subsub1": "vvvvv"
    }
  },
  "hoge3": ["1", "2", "3"],
  "hoge4": [{"key1": "v1"}, {"key1": "v2"}]
}

class Metadata {
  static props() {
    return {
      key1: String,
      key2: [String],
      key3: Hoge
    }
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

class Hoge extends Metadata {
  static props() {
    return {
      hoge1: String
    }
  }
}

const raw = {
  key1: "hoge",
  key2: ["hoge1", "hoge2"],
  key3: {
    hoge1: "hoge3"
  }
}
const data = new Metadata(raw)
console.log(data.toJSON())
