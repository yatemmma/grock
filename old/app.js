var React = require('react');

class App extends React.Component {
  render() {
    var list = this.props.data.map(obj => <li key={obj.id}>{obj.id}:{obj.name}</li>);
    return (
      <div>
        <p>server-side rendering sample</p>
        <ul>{list}</ul>
      </div>
    );
  }
}

module.exports = App;
