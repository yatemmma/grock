const Models = require("./grock/models/models")

const args = {
  code: "hoge_label"
}
const className = "Label"
const Clazz = Models[className]

const data = new Clazz(args)
console.log(data)

const fs = require("fs")

fs.writeFileSync("data/hoge.json", JSON.stringify([data.toJSON()], null, 4))

// 既存データの読み込み
//
