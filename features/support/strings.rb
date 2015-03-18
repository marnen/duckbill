module StringHelpers
  def string_for(identifier)
    case identifier
    when nil
      # placeholder for explicit mappings
    else
      begin
        path = identifier.gsub(/^the\s+/, '').split.collect {|key| key.chomp "'s" }
        result = instance_variable_get "@#{path.shift}"
        path.each do |key|
          result = result.send key
        end
        result
      rescue NoMethodError
        raise ArgumentError, "String identifier '#{identifier}' is not defined. Please add a mapping in #{__FILE__}."
      end
    end
  end
end

World StringHelpers