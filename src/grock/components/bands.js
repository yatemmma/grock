const React = require("react")
const BaseComponent = require("./basecomponent")
const Head = require("./subcomponents/head")

class Bands extends BaseComponent {
  render() {
    console.log(this.props.bands[0].constructor.getData("Band"))
    return (
      <html>
        <Head data={{title: "Bands"}} />
        <body>

        </body>
      </html>
    )
  }
}

module.exports = Bands
