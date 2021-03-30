use Mix.Config

config :recaptcha,
  verify_url: "https://www.google.com/recaptcha/api/siteverify",
  timeout: 5000,
  public_key: "RECAPTCHA_PUBLIC_KEY",
  secret: "RECAPTCHA_PRIVATE_KEY",
  http_client: Recaptcha.Http

config :recaptcha, :json_library, Jason

import_config "#{Mix.env()}.exs"
