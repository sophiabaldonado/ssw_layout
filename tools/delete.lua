-- Delet

local Delete = {}

Delete.name = 'Delete'
Delete.context = 'hover'
Delete.button = 'right'

function Delete:use(controller, entity)
  self.layout:removeEntity(entity)
end

return Delete
