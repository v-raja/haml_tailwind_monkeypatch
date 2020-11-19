module Haml
  # Haml::AttriubuteParser parses Hash literal to { String (key name) => String (value literal) }.
  module AttributeParser
    class << self
      # @param  [String] exp - Old attributes literal or Hash literal generated from new attributes.
      # @return [Hash<String, String>,nil] - Return parsed attribute Hash whose values are Ruby literals, or return nil if argument is not a single Hash literal.
      def parse(exp)
        return nil unless hash_literal?(exp)

        hash = Hash.new{"\"\""}
        each_attribute(exp) do |key, value|
          if key.in?(['f', 'h', 'sm', 'md', 'lg', 'xl', 'focus', 'hover'])
            # Build up string to insert into class attribute
            tw_classes = value[1..-2]   # Remove the esacped quotes from the original string
                          .split        # Split into array
                          .map{ |clas| "#{attribute_name(key)}:#{clas}" }
                          .join(" ")

            # Insert tw classes string before last escape quote
            hash['class'] = hash['class'].insert(-2, " #{tw_classes}")
            # puts hash
            # raise
          elsif key.in?(['c', 'class', 'sm'])
            hash['class'] = hash['class'].insert(-2, " #{value[1..-2]}")
          else
            hash[key] = value
          end
        end
        hash
      rescue UnexpectedTokenError, UnexpectedKeyError
        nil
      end

      # Returns name of attribute based on first letter if defined, else
      # original string
      def attribute_name(first_letter)
        if first_letter == 'f'
          "focus"
        elsif first_letter == 'h'
          "hover"
        else
          first_letter
        end
      end
    end
  end
end
