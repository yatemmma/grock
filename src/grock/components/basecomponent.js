const React = require("react")

class BaseComponent extends React.Component {
  link(path) {
    const f = require("../helpers/link").link(this.props.level)
    return f(path)
  }

}

module.exports = BaseComponent
