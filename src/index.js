const Models = require("./grock/models/models")

const band = new Models.Band()
// console.log(band.data)
// console.log(band.toJSON())

const fs = require("fs")
const data_list = JSON.parse(fs.readFileSync("data/band.json").toString())
console.log(data_list)
const band_list = data_list.map((data)=>{
  return new Models.Band(data)
})

Models.Band.setData("Band", band_list)

console.log(band_list)

const React = require("react")
const ReactDOMServer = require("react-dom/server")

const Components = require("./grock/components/components")
const data = {
  bands: band_list,
  level: 0
}
const x = ReactDOMServer.renderToStaticMarkup(React.createElement(Components.Bands, data))

console.log(111, x)


fs.writeFileSync("docs/bands.html", x)


// Band => 空テンプレ作る
// Band => dbへ
// Band <= dbから
// toJSON: Band => jsonへ
// parseJSON: Band => jsonから

// Band（Band, Solo, Unit, Member)
// - Bands（Band List）
// - Guests（Guest Appearance）
// - Solo Works
// Disc（Album, Single, Video, Cover, Live, Xmas, VA, Split）
// - Discs
// - Videos
// - Covers
// - Complirations
// Label
// -
