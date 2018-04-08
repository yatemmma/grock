const React = require("react");
const BaseComponent = require("../basecomponent");

class Head extends BaseComponent {
  render() {
    const title = [this.props.data.title, "G-ROCK"].filter(word => word).join(" | ");
    return React.createElement(
      "head",
      null,
      React.createElement("meta", { charSet: "utf-8" }),
      React.createElement("meta", { name: "viewport", content: "width=device-width,initial-scale=1" }),
      React.createElement(
        "title",
        null,
        title
      ),
      React.createElement("link", { rel: "shortcut icon", type: "image/x-icon", href: this.link("assets/images/favicon.ico") }),
      React.createElement("link", { media: "all", rel: "stylesheet", href: this.link("assets/vendor/css/fontawesome-all.min.css") }),
      React.createElement("link", { media: "all", rel: "stylesheet", href: this.link("assets/style.css") }),
      React.createElement("script", { src: this.link("assets/script.js"), async: true })
    );
  }
}

module.exports = Head;