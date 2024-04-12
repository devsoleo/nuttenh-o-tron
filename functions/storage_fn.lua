NOTSVPC = {}

function set_storage(key, value)
    NOTSVPC[key] = value
end

function get_storage(key)
    return NOTSVPC[key]
end

