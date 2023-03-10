defmodule PlateSlateWeb.Graphql.InputTypes.SignupInput do
  @moduledoc false

  use Absinthe.Schema.Notation

  input_object :signup_input do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :role, non_null(:role)
  end
end
