var columns = ['name', 'n', 'm', 'degrees'];
var e = encodeURIComponent;

function addQuerystringBuilder() {
  var builderLink = document.createElement('a');

  builderLink.id = 'builderlink';
  builderLink.title = 'Bookmark this filter';
  builderLink.appendChild(document.createTextNode('Bookmark'));

  document.getElementById('flt4_graphdb').parentNode.
    appendChild(builderLink);
};

function buildQuerystring() {
  var params = [];

  for (var i = 0; i < columns.length; i++) {
    var input = document.getElementById('flt' + i + '_graphdb');
    if (input.value != '') {
      params.push(e(columns[i]) + '=' + e(input.value));
    }
  }

  document.getElementById('builderlink').
    href = './?' + params.join('&');
}

function querystringFilter() {
  addQuerystringBuilder();

  var querystring = new Querystring();

  for (var i = 0; i < columns.length; i++) {
    var value = querystring.get(columns[i]);
    if (value) {
      tf_graphdb.SetFilterValue(i, value);
    }
  }

  tf_graphdb.Filter();
};

var graphdb_config = {
  on_keyup : true, filters_row_index : 1, col_4 : 'none',
  on_filters_loaded : querystringFilter,
  on_before_filter : buildQuerystring,
};
