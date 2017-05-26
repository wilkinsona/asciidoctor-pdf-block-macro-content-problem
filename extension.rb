require 'asciidoctor/extensions'
require 'stringio'

Asciidoctor::Extensions.register do
  block_macro TestBlockMacro
end

class TestBlockMacro < Asciidoctor::Extensions::BlockMacroProcessor
  use_dsl
  named :test

  def process(parent, operation, attributes)
    options = { safe: parent.document.options[:safe],
                attributes: { 'fragment' => '',
                              'projectdir' => parent.document.attr(:projectdir) } }
    content = "=== Bar\n\nSome content\n\n=== Baz\n\nSome more content"
    fragment = Asciidoctor.load content, options
    fragment.blocks.each do |b|
      b.parent = parent
      parent << b
    end
    nil
  end

end