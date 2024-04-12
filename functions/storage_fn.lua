NOTSVPC = {}

function set_storage(key, value)
    NOTSVPC[key] = value
end

function get_storage(key)
    return NOTSVPC[key]
end

function clear_storage(key)
    set_storage(key, nil)
end