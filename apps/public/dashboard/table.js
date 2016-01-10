function request(method, params, success, failure) {
  $.ajax({
    url: "/data/"+path,
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
  cols.forEach(function(item) {
    obj[item] = $('#'+item+'-field').val();
  });
  request('post', obj, function(result) {
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
  cols.forEach(function(item) {
    obj[item] = $('#'+item+'-field').val();
  });
  request('put', obj, function(result) {
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
      var itemId = $(this).closest('tr').find('.id').text();
      request('delete', {id: itemId}, function(result) {
        list.remove('id', itemId);
      }, function(message) {
        alert('error occured:'+message);
      });
	  }
  });
  
  editBtns.click(function() {
    var itemId = $(this).closest('tr').find('.id').text();
    var itemValues = list.get('id', itemId)[0].values();
    cols.forEach(function(item) {
      $('#'+item+'-field').val(itemValues[item]);
    });
    
    editBtn.show();
    addBtn.hide();
  });
}

function clearFields() {
  $('.adding-field').val('');
}
