module ReverseMarkdown
  module Converters
    class Iframe < Base
      def convert(node, state = {})
        node.to_s
      end
    end
    
    register :iframe, Iframe.new
  end
end
