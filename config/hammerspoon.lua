hs.loadSpoon("URLDispatcher")

spoon.URLDispatcher.url_patterns = {
	{ "https://.*%.zoom%.us/j", "us.zoom.xos" },
	-- Do not match URLs with query params; the app can't handle them
  { "https://.+%.slack%.com/archives/[^%?]+$", "com.tinyspeck.slackmacgap" },
  { "https://linear%.app/.*/issue", "com.linear" },
  { "https://www%.notion%.so", "notion.id" },
  { "https://www%.figma%.com/design", "com.figma.Desktop" },
}

spoon.URLDispatcher.default_handler = "com.google.Chrome"

spoon.URLDispatcher:start()
