const React = require('react')
const ReactDOMServer = require('react-dom/server')
require('node-jsx').install({ harmony: true })

var MyComponent = require('./test');

const x = ReactDOMServer.renderToString(React.createElement(MyComponent, {}));
console.log(x)
