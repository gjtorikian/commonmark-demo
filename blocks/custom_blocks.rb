require 'extended-markdown-filter'

require 'test/unit/assertions'
include Test::Unit::Assertions

content = <<~DOC
_Hello_ there!

{{#note}}

Psst...here is a note.

{{/note}}
DOC

output = ExtendedMarkdownFilter.to_document(content, {}).to_s

result = <<~DOC
<p><em>Hello</em> there!</p>
<div class="alert note">
<p>Psst...here is a note.</p>
</div>
DOC

assert_equal output, result.chomp

puts result
