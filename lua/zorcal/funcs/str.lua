local M = {}

M.ends_with = function(str, suffix)
  -- Check if the suffix is longer than the string, in which case it cannot be a suffix.
  if #suffix > #str then
    return false
  end

  -- Get the substring from the end of the string with the same length as the suffix.
  local endSubstring = string.sub(str, -#suffix)

  -- Compare the end substring with the suffix and return the result.
  return endSubstring == suffix
end

M.ends_with_any = function(str, suffixes)
  for _, suffix in ipairs(suffixes) do
    if M.ends_with(str, suffix) then
      return true
    end
  end
  return false
end

M.contains_any = function(str, substrings)
  for _, substring in ipairs(substrings) do
    if string.find(str, substring) then
      return true
    end
  end
  return false
end

return M
