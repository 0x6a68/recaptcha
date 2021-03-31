defmodule Recaptcha.Http.Interface do
  @callback request_verification(binary, timeout: integer) ::
              {:ok, map} | {:error, [atom]}
end
