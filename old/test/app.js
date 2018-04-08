var React = require('react');

class App extends React.Component {
  render() {
    var list = this.props.data.map(obj => React.createElement(
      'li',
      { key: obj.id },
      obj.id,
      ':',
      obj.name
    ));
    return React.createElement(
      'div',
      null,
      React.createElement(
        'p',
        null,
        'server-side rendering sample'
      ),
      React.createElement(
        'ul',
        null,
        list
      )
    );
  }
}

module.exports = App;