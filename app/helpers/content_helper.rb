module ContentHelper
  # 返回处理 link mention 后的 text
  def content_format(text)
    t = String.new text
    # @username => <a href="/~username">@username</a>
    t.gsub!(/@([a-z0-9]+)/i) do |match|
      %Q|<a href="/users/#{ $1 }">#{ match }</a>|
    end

    t.gsub!(/#([\w]+|[\u4e00-\u9fa5]+)#/) do |match|
      %Q|<a href="/topics/#{ $1 }">#{ match }</a>|
    end

    sanitize t, tags: %w(a), attributes: %w(href)
  end
end
