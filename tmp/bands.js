const React = require("react");

class App extends React.Component {
  render() {
    console.log(this.props.data_list);
    var list = this.props.data_list.map(obj => React.createElement(
      "li",
      { key: obj.data.code },
      obj.data.code
    ));
    return React.createElement(
      "div",
      null,
      React.createElement(
        "p",
        null,
        "server-side rendering sample"
      ),
      React.createElement(
        "ul",
        null,
        list
      )
    );
  }
}

module.exports = App;