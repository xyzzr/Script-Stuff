function case1UnicodeToUtf8(unicodeValue)
  local u = unicodeValue
  local byte0 = (u % 0x80)
  local utf8 = string.char(byte0)
  return utf8
end

function case2UnicodeToUtf8(unicodeValue)
  local u = unicodeValue
  local byte1 = (0x80 + (u % 0x40) )
  u = math.floor(u / 0x40)
  local byte0 = (0xc0 + (u % 0x20) )
  local utf8 = string.char(byte0, byte1)
  return utf8
end

function case3UnicodeToUtf8(unicodeValue)
  local u = unicodeValue
  local byte2 = (0x80 + (u % 0x40))
  u = math.floor(u / 0x40)
  local byte1 = (0x80 + (u % 0x40))
  u = math.floor(u / 0x40)
  local byte0 = (0xe0 + (u % 0x10))
  local utf8 = string.char(byte0, byte1, byte2)
  return utf8
end

function case4UnicodeToUtf8(unicodeValue)
  local u = unicodeValue
  local byte3 = (0x80 + (u % 0x40))
  u = math.floor(u / 0x40)
  local byte2 = (0x80 + (u % 0x40))
  u = math.floor(u / 0x40)
  local byte1 = (0x80 + (u % 0x40))
  u = math.floor(u / 0x40)
  local byte0 = (0xf0 + (u % 0x8))
  local utf8 = string.char(byte0, byte1, byte2, byte3)
  return utf8
end

function unicodeToUtf8(unicodeValue)
  local u = unicodeValue
  if type(u) == "string" then
	u = tonumber(u,16)
  end
  if ((0x800 <= u) and (0xffff >= u))
  then
    return case3UnicodeToUtf8(u)
  end
  if ((0x80 <= u) and (0x7fff >= u))
  then
    return case2UnicodeToUtf8(u)
  end
  if ((0x0 <= u) and (0x7f >= u))
  then
    return case1UnicodeToUtf8(u)
  end
  if( (0x10000 <= u) and (0x10ffff >= u) )
  then
    return case4UnicodeToUtf8(u)
  end
  return nil
end

return unicodeToUtf8
