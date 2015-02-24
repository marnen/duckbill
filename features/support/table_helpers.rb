module TableHelpers
  def check_rows(table, expected: true, &predicate)
    table.rows_hash.each do |field, value|
      expect(predicate.call field, value).to be == expected
    end
  end

  def params_from(table)
    table.rows_hash.transform_keys {|key| remove_spaces key.downcase.delete '-' }
  end
end

World TableHelpers