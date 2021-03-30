use Mix.Config

config :recaptcha,
  http_client: Recaptcha.Http.Mock,
  secret: "test_secret",
  public_key: "test_public_key"
