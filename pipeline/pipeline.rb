require 'html/pipeline'
require 'extended-markdown-filter'

require 'test/unit/assertions'
include Test::Unit::Assertions

pipeline = HTML::Pipeline.new [
  ExtendedMarkdownFilter,
  HTML::Pipeline::TableOfContentsFilter
]

doc = <<-DOC
# More words

_Some words_.

{{#note}}

Another note.

{{/note}}

## More words
DOC

output = pipeline.call(doc)[:output].to_s

result = <<-DOC
<h1>
<a id="more-words" class="anchor" href="#more-words" aria-hidden="true"><span aria-hidden="true" class="octicon octicon-link"></span></a>More words</h1>
<p><em>Some words</em>.</p>
<div class="alert note">
<p>Another note.</p>
</div>
<h2>
<a id="more-words-1" class="anchor" href="#more-words-1" aria-hidden="true"><span aria-hidden="true" class="octicon octicon-link"></span></a>More words</h2>
DOC

assert_equal output, result.chomp

puts result
