const React = "react"
const renderToString = "react-dom/server".renderToString
const App = "App"

function renderFullPage(renderedContent) {
  return `
  <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <title>React Server Rendering sample</title>
    </head>

    <div id="app">${renderedContent}</div>

    <script type="text/javascript" charset="utf-8" src="/assets/app.js"></script>
    </body>
    </html>

  `
}

function render(req, res) {
  const renderedContent = renderToString(<App />)
  const renderedPage = renderFullPage(renderedContent)
  res.status(200).send(renderedPage)
}

module.exports = render
