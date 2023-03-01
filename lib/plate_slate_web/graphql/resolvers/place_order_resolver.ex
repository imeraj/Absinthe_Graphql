defmodule PlateSlateWeb.Graphql.Resolvers.PlaceOrderResolver do
  @moduledoc false

  alias PlateSlate.Ordering

  def place_order(_, %{input: params}, _) do
    with {:ok, order} <- Ordering.create_order(params) do
      Absinthe.Subscription.publish(PlateSlateWeb.Endpoint, order, new_order: "*")

      # this is because menu_item is a basic type. We don't need to return a map
      {:ok, order}
    end
  end
end
