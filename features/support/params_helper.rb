module ParamsHelper
  def params_from(table)
    table.rows_hash.transform_keys {|key| key.downcase.delete '-' }
  end
end

World ParamsHelper