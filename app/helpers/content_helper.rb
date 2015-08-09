module ContentHelper
  # 返回处理 link mention 后的 text
  def content_format(text)
    # @username => <a href="/~username">@username</a>
    text.gsub!(/@([a-z0-9][a-z0-9-]*)/i) { |match|
      %Q|<a href="/users/#{$1}">#{match}</a>|
    }

    sanitize text, tags: %w(a), attributes: %w(href)
  end
end
