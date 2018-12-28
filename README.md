# Usage


**init.lua**
```
require 'module'

import 'my_module'
func()

local lib = module.load('my_module')
lib.func()
```

**my_module**

```
function func()
  print 'Hello from my_module'
end
```
