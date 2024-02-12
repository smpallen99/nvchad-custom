return {
  -- Please start with minimal config possible.
  -- Just openai_api_key if you don't have OPENAI_API_KEY env set up.
  -- Defaults change over time to improve things, options might get deprecated.
  -- It's better to change only things where the default doesn't fit your needs.
  --
  -- required openai api key (string or table with command and arguments)
  openai_api_key = { "cat", "/Users/spallen/.api-key" },
  -- openai_api_key = { "bw", "get", "password", "OPENAI_API_KEY" },
  -- openai_api_key: "sk-...",
  -- openai_api_key = os.getenv("OPENAI_API_KEY"),
  -- api endpoint (you can change this to azure endpoint)
  openai_api_endpoint = "https://api.openai.com/v1/chat/completions",
  -- openai_api_endpoint = "https://$URL.openai.azure.com/openai/deployments/{{model}}/chat/completions?api-version=2023-03-15-preview",
  -- prefix for all commands
  cmd_prefix = "Gp",
  -- optional curl parameters (for proxy, etc.)
  -- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
  curl_params = {},
}
