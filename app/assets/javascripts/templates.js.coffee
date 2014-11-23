$ ->
  $(document).on 'click', '#add_new_item', ->
    $('#item_name_div').append('<div class="field">
        <label for="template_item_name">Item name</label>
        <input type="text" name="template[item_name][]" id="template_item_name">
        <a id="remove_added_field"><i class="glyphicon glyphicon-trash"></i></a>
      </div>')

    return false

  $(document).on 'click', '#remove_added_field', ->
    $(@).parent().remove()