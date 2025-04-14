hs.loadSpoon("URLDispatcher")

spoon.URLDispatcher.url_patterns = {
	{ "https://.*%.zoom%.us/j", "us.zoom.xos" },
  { "https://linear%.app/.*/issue", "com.linear" },
  { "https://www%.notion%.so", "notion.id" },
  { "https://www%.figma%.com/design", "com.figma.Desktop" },
}

spoon.URLDispatcher.default_handler = "com.google.Chrome"

spoon.URLDispatcher:start()
