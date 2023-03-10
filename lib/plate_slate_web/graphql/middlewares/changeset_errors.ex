defmodule PlateSlateWeb.Middlewares.ChangesetErrors do
  @moduledoc false

  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    with %{errors: [%Ecto.Changeset{} = changeset]} <- resolution do
      %{resolution | value: %{errors: transform_errors(changeset)}, errors: []}
    end
  end

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn
      {key, value} ->
        %{key: key, message: value}
    end)
  end

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
