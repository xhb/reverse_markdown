require 'spec_helper'

describe ReverseMarkdown::Converters::Pre do

  let(:converter) { ReverseMarkdown::Converters::Pre.new }

  context 'for standard markdown' do
    before { ReverseMarkdown.config.github_flavored = false }

    it 'converts with indentation' do
      node = node_for("<pre>puts foo</pre>")
      expect(converter.convert(node)).to include "    puts foo\n"
    end
  end

  context 'for github_flavored markdown' do
    before { ReverseMarkdown.config.github_flavored = true }

    it 'converts with backticks' do
      node = node_for("<pre>puts foo</pre>")
      expect(converter.convert(node)).to include "```\nputs foo\n```"
    end

    context 'syntax highlighting' do
      it 'works for "highlight-lang" mechanism' do
        div = node_for("<div class='highlight highlight-ruby'><pre>puts foo</pre></div>")
        pre = div.children.first
        expect(converter.convert(pre)).to include "```ruby\n"
      end

      it 'works for the confluence mechanism' do
        pre = node_for("<pre class='theme: Confluence; brush: html/xml; gutter: false'>puts foo</pre>")
        expect(converter.convert(pre)).to include "```html/xml\n"
      end
    end
  end

end
