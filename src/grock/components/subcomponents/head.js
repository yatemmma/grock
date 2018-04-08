const React = require("react")
const BaseComponent = require("../basecomponent")

class Head extends BaseComponent {
  render() {
    const title = [this.props.data.title, "G-ROCK"].filter(word => word).join(" | ")
    return (
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>{title}</title>
        <link rel="shortcut icon" type="image/x-icon" href={this.link("assets/images/favicon.ico")} />
        <link media="all" rel="stylesheet" href={this.link("assets/vendor/css/fontawesome-all.min.css")} />
        <link media="all" rel="stylesheet" href={this.link("assets/style.css")} />
        <script src={this.link("assets/script.js")} async />
      </head>
    )
  }
}

module.exports = Head
