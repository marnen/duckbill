module TableHelpers
  def params_from(table)
    table.rows_hash.transform_keys {|key| remove_spaces key.downcase.delete '-' }
  end
end

World TableHelpers