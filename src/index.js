const Models = require("./grock/models/models")

const band = new Models.Band()

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
