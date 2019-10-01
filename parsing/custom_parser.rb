require 'commonmarker'
require 'test/unit/assertions'
include Test::Unit::Assertions

class MyHtmlRenderer < CommonMarker::HtmlRenderer
  def link(node)
    node.url = "/articles#{node.url}"
    super
  end
end

doc = CommonMarker.render_doc('_Hello_ [foo](/bar)')

myrenderer = MyHtmlRenderer.new
result = myrenderer.render(doc).chomp

assert_equal result, '<p><em>Hello</em> <a href="/articles/bar">foo</a></p>'

puts result
