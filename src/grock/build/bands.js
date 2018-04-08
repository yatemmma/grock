const React = require("react");
const BaseComponent = require("./basecomponent");
const Head = require("./subcomponents/head");

class Bands extends BaseComponent {
  render() {
    console.log(this.props.bands[0].constructor.getData("Band"));
    return React.createElement(
      "html",
      null,
      React.createElement(Head, { data: { title: "Bands" } }),
      React.createElement("body", null)
    );
  }
}

module.exports = Bands;