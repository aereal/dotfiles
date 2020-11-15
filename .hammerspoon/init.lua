hs.window.animationDuration = 0

viKey = hs.hotkey.modal.new('ctrl-cmd', 'delete', 'hammerspoon')
function viKey:entered() hs.alert'Enter' end
function viKey:exited() hs.alert'Exit' end
viKey:bind('', 'escape', function() viKey:exit() end)
units = {
  enter = { x = 0.0, y = 0.0, w = 1.0, h = 1.0 },
  spc   = { x = 0.125, y = 0.125, w = 0.75, h = 0.75 },
  h     = { x = 0.0, y = 0.0, w = 0.5, h = 1.0 },
  l     = { x = 0.5, y = 0.0, w = 0.5, h = 1.0 },
  j     = { x = 0.0, y = 0.5, w = 1.0, h = 0.5 },
  k     = { x = 0.0, y = 0.0, w = 1.0, h = 0.5 },
  i     = { x = 0.0, y = 0.0, w = 0.5, h = 0.5 },
  o     = { x = 0.5, y = 0.0, w = 0.5, h = 0.5 },
  n     = { x = 0.0, y = 0.5, w = 0.5, h = 0.5 },
  m     = { x = 0.5, y = 0.5, w = 0.5, h = 0.5 },
}
viKey:bind('', 'return', function()
  hs.window.focusedWindow():move(units.enter)
end)
viKey:bind('', 'space', function()
  hs.window.focusedWindow():move(units.spc)
end)
viKey:bind('', 'h', function()
  hs.window.focusedWindow():move(units.h)
end)
viKey:bind('', 'l', function()
  hs.window.focusedWindow():move(units.l)
end)
viKey:bind('', 'j', function()
  hs.window.focusedWindow():move(units.j)
end)
viKey:bind('', 'k', function()
  hs.window.focusedWindow():move(units.k)
end)
viKey:bind('', 'i', function()
  hs.window.focusedWindow():move(units.i)
end)
viKey:bind('', 'o', function()
  hs.window.focusedWindow():move(units.o)
end)
viKey:bind('', 'n', function()
  hs.window.focusedWindow():move(units.n)
end)
viKey:bind('', 'm', function()
  hs.window.focusedWindow():move(units.m)
end)
