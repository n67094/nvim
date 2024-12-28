local Module = {}

function Module.setup()
  local status_1, comment = pcall(require, "Comment")
  local status_2, ft = pcall(require, "Comment.ft")
  if not status_1 or not status_2 then
    print("The plugin comment is not installed")
    return
  end

  comment.setup()

  ft.set('c', { '//%s', '/*%s*/' })
end

return Module
