const React = require('react')
const ReactDOMServer = require('react-dom/server')
require('node-jsx').install({ harmony: true })

var App = require('./app');

var data = [
  { id: 1, name: 'backbone' },
  { id: 2, name: 'react' },
  { id: 3, name: 'angular' },
];

const x = ReactDOMServer.renderToString(React.createElement(App, {data: data}))

console.log(x)
