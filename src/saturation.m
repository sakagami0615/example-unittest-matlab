function dst_value = saturation(src_value, max_value, min_value)

src_type = class(src_value);
max_type = class(max_value);
min_type = class(min_value);

if ~(strcmp(src_type, max_type) && strcmp(src_type, min_type))
    e = MException('saturation:variableDataTypeMismatch', 'Argument variable mismatch (%s, %s, %s)', src_type, max_type, min_type);
    throw(e);
end

dst_value = src_value;
dst_value = max(dst_value, min_value);
dst_value = min(dst_value, max_value);

end

