local module = {}
function module.new()
    local _L = {}

    local function get(self, key)
        if key == '_L' then
            return _L
        end
        return _L[key] or _G[key]
    end

    local function set(self, key, value)
        _L[key] = value
    end

    return setmetatable({}, { __index = get, __newindex = set })
end

local modules = {}
function module.load(path, L)
    local env = modules[path]

    if not env then
        env = module.new()
        assert(pcall(setfenv(loadfile(path..'.lua'), env)))
        modules[path] = env
    end

    L = L or {}
    for k, v in pairs(env._L) do
        L[k] = v
    end
    return L
end

_G.module = module
_G.import = function(path)
    module.load(path, getfenv(2)._L)
end
_G.export = function(name, value)
    _G[name] = value or getfenv(2)[name]
end

setfenv(3, module.new())
