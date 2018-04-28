module UsersHelper extend ActionView::Helpers::FormHelper
	def validation_error_tooltip(errors_messages, method, main_class = {}, body_class = {})
		tooltip_options = {class: 'form-control-error'}
		tooltip_options[:class] += ' ' + main_class[:class].to_s
		body_options = { class: 'tooltip-inner'}
		body_options[:class] += ' ' + body_class[:class].to_s

		errors_list_items = nil
		errors_messages[method].each_with_index do |message, index| 
			errors_list_items = content_tag(:li, message, {} ) if index.zero?
			next if index.zero?
			errors_list_items += content_tag(:li, message, {} )
		end

		errors_list = content_tag :ul, errors_list_items, {class: 'mb-0 pl-3'}

		tooltip_body = content_tag :div, errors_list, body_options
		tooltip_arrow = content_tag :div, '', {class: 'arrow'}
		tooltip = content_tag :div, errors_list , tooltip_options
		tooltip
	end
end
