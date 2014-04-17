## Attribution
# This class is a direct copy of the sanitizedata.rb processor
# from the sentry-raven gem. All source licensing applies.
#
# https://github.com/getsentry/raven-ruby/blob/master/lib/raven/processors/sanitizedata.rb
#
# The only local modification is to the FIELDS_RE regex
# to match SSN-like strings.


require 'raven/processor'

module Raven
  module Processor
    class SanitizeSSN < Processor

      VERSION = "0.0.1"

      MASK = '********'
      FIELDS_RE = /(ssn|social(.*)?sec)/i
      VALUES_RE = /^\d{16}$/

      def apply(value, key = nil, visited = [], &block)
        if value.is_a?(Hash)
          return "{...}" if visited.include?(value.__id__)
          visited += [value.__id__]

          value.each.reduce({}) do |memo, (k, v)|
            memo[k] = apply(v, k, visited, &block)
            memo
          end
        elsif value.is_a?(Array)
          return "[...]" if visited.include?(value.__id__)
          visited += [value.__id__]

          value.map do |value_|
            apply(value_, key, visited, &block)
          end
        else
          block.call(key, value)
        end
      end

      def sanitize(key, value)
        if !value.is_a?(String) || value.empty?
          value
        elsif VALUES_RE.match(clean_invalid_utf8_bytes(value)) || FIELDS_RE.match(key)
          MASK
        else
          clean_invalid_utf8_bytes(value)
        end
      end

      def process(data)
        apply(data) do |key, value|
          sanitize(key, value)
        end
      end

      private

      def clean_invalid_utf8_bytes(text)
        if RUBY_VERSION <= '1.8.7'
          text
        else
          text.encode(
            'UTF-8',
            'binary',
            :invalid => :replace,
            :undef => :replace,
            :replace => ''
          )
        end
      end
    end
  end
end