module ParamsHelper
  def params_from(table)
    table.rows_hash.transform_keys &:downcase
  end
end

World ParamsHelper