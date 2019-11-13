require 'html/pipeline'
require 'commonmarker'

require 'test/unit/assertions'
include Test::Unit::Assertions

pipeline = HTML::Pipeline.new [
  HTML::Pipeline::MarkdownFilter
], unsafe: true, commonmarker_extensions: HTML::Pipeline::MarkdownFilter::DEFAULT_COMMONMARKER_EXTENSIONS - [:tagfilter]

doc = <<-DOC
# More words

_Some words_.

<iframe id="inlineFrameExample"
    title="Inline Frame Example"
    width="300"
    height="200"
    src="https://www.openstreetmap.org/export/embed.html?bbox=-0.004017949104309083%2C51.47612752641776%2C0.00030577182769775396%2C51.478569861898606&layer=mapnik">
</iframe>

_Wow!_

DOC

output = pipeline.call(doc)[:output].to_s

result = <<-DOC
<h1>More words</h1>
<p><em>Some words</em>.</p>
<iframe id="inlineFrameExample"
    title="Inline Frame Example"
    width="300"
    height="200"
    src="https://www.openstreetmap.org/export/embed.html?bbox=-0.004017949104309083%2C51.47612752641776%2C0.00030577182769775396%2C51.478569861898606&layer=mapnik">
</iframe>
<p><em>Wow!</em></p>
DOC

assert_equal output, result.chomp

puts result
