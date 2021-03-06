-- Does it scale

local Scale = {}

Scale.name = 'Scale'
Scale.continuous = true
Scale.context = 'hover'
Scale.button = 'trigger'
Scale.twoHanded = true

function Scale:start(controller, entity)
  self.bzz = 0
  self.distance = nil
end

function Scale:use(controller, entity, dt)
  local otherController = self.layout:getOtherController(controller)

  -- Scale the entity using the change in the distance between controllers
  local x1, y1, z1 = self.layout:getCursorPosition(controller)
  local x2, y2, z2 = self.layout:getCursorPosition(otherController)
  local distance = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2 + (z2 - z1) ^ 2)
  local ref = self.distance or distance
  local ratio = distance / ref
  entity.scale = entity.scale * ratio
  self.layout:dirty()

  -- Bzz
  self.bzz = self.bzz + math.abs(distance - ref)
  if self.bzz >= .1 then
    self.layout:vibrate(controller, .25, .001)
    self.layout:vibrate(otherController, .25, .001)
    self.bzz = 0
  end

  -- Update the reference distance
  self.distance = distance
end

return Scale
