function request(method, params, success, failure) {
  $.ajax({
    url: "data/"+options.path,
    method: method,
    data: params,
    dataType: "json"
  }).done(success).fail(failure);
}

var list = new List('items', options);
var addBtn = $('#add-btn'),
    editBtn = $('#edit-btn').hide(),
    removeBtns = $('.remove-item-btn'),
    editBtns = $('.edit-item-btn'),
    idField = $('#id-field');

// Sets callbacks to the buttons in the list
refreshCallbacks();

addBtn.click(function() {
  obj = {}
  options.valueNames.forEach(function(item) {
    if (item == 'id') {
      obj.id = Math.floor(Math.random()*110000);
    } else {
      obj[item] = $('#'+item+'-field').val();
    }
  });
  request('post', obj, function(result) {
    // TODO: add id
    list.add(obj);
    clearFields();
    refreshCallbacks();  
  }, function(message) {
    alert('error occured:'+message);
  });
});

editBtn.click(function() {
  var item = list.get('id', idField.val())[0];
  obj = {}
  options.valueNames.forEach(function(item) {
    obj[item] = $('#'+item+'-field').val();
  });
  request('put', obj, function(result) {
    // TODO: add id
    item.values(obj);
    clearFields();
    editBtn.hide();
    addBtn.show();
  }, function(message) {
    alert('error occured:'+message);
  });
});

function refreshCallbacks() {
  // Needed to add new buttons to jQuery-extended object
  removeBtns = $(removeBtns.selector);
  editBtns = $(editBtns.selector);
  
  removeBtns.click(function() {
    if (window.confirm('remove?')) {
      var that = this;
      request('delete', obj, function(result) {
        var itemId = $(that).closest('tr').find('.id').text();
        list.remove('id', itemId); 
      }, function(message) {
        alert('error occured:'+message);
      });
	  }
  });
  
  editBtns.click(function() {
    var itemId = $(this).closest('tr').find('.id').text();
    var itemValues = list.get('id', itemId)[0].values();
    options.valueNames.forEach(function(item) {
      $('#'+item+'-field').val(itemValues[item]);
    });
    
    editBtn.show();
    addBtn.hide();
  });
}

function clearFields() {
  $('.adding-field').val('');
}
