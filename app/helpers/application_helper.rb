module ApplicationHelper

	def title(page_title)
	  content_for :title, "ReportsManager | " + page_title.to_s
	end

	def print_notice(notice)
		-> {
			content_tag(:div, class:'alert alert-success') do
				content_tag(:button, 'x', class:'close', :'data-dismiss'=>:'alert') +
				notice
			end
		}.call if notice
	end


	def error_field(class_name)
		-> {
			content_tag(:div, class:'alert alert-danger') do
				link_to("x", '#', class:'close', :'data-dismiss' => :'alert') +
				content_tag(:h3, "#{pluralize(class_name.errors.count, "error")} prohibited this post from being saved:") +
				content_tag(:ul) do
					class_name.errors.full_messages.each do |msg|
						concat content_tag(:li, msg)
					end
				end
			end
		}.call if class_name.errors.any?
	end
	
end
