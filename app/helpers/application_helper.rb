module ApplicationHelper
  def devise_error_messages
    return "" if resource.errors.empty?
    html = ""
    resource.errors.full_messages.each do |msg|
      html += <<-EOF
        <div class="error_field" role="alert">
          <p class="error_msg">#{msg}</p>
        </div>
      EOF
    end
    html.html_safe
  end

  require "uri"

  def text_url_to_link(text)
    URI.extract(text, ['http', 'https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    text
  end
end
