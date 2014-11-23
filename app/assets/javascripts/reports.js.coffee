$ -> 
  $(document).on 'click', '#add_additon_value', ->
    item_id = $(@).data('id')
    $('#item_' + item_id).append('<div><input type="text" name="report[item_value]['+item_id+'][]"><a id="remove_added_field">
            <i class="glyphicon glyphicon-trash"></i>
          </a></div>')