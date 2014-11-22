$ -> 
	$(document).on 'click', '#add_additon_value', ->
		item_id = $(@).data('id')
		$('#item_' + item_id).append('<div><input type="text" name="report[item_value]['+item_id+'][]"><a id="remove_append_value">remove</a></div>')
	
	$(document).on 'click', '#remove_append_value', ->
		$(@).parent().remove()