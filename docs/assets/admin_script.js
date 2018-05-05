function exportData(e, sender) {
  e.preventDefault()
  const model = sender.text
  sender.text = "..."
  ajaxRequest("./admin/api/export", {model: model}, function(result) {
      sender.text = model
      console.log(result)
    })
}

function importData(e, sender) {
  e.preventDefault()
  if (!confirm("Import data?")) {
    return
  }
  const model = sender.text
  sender.text = "..."
  ajaxRequest("./admin/api/import", {model: model}, function(result) {
      sender.text = model
      console.log(result)
    })
}
