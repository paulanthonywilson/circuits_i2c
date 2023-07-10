defmodule Circuits.I2C.I2cBehaviour do
  @moduledoc """
  A behaviour that adds a testing seam to `Circuits.I2C` to make developing a little bit easier to test.

  While the 2.0 version does come with the ability to swap in different back-ends, using a behaviour is a simpler way
  of testing, eg using [Mox](https://hexdocs.pm/mox/).
  """

  @type address() :: 0..127

  @type bus() :: reference()

  @type present?() :: (bus(), address() -> boolean())

  @type opt() :: {:retries, non_neg_integer()}

  @callback open(binary() | charlist()) :: {:ok, bus()} | {:error, term()}

  @callback read(bus(), address(), pos_integer(), [opt()]) :: {:ok, binary()} | {:error, term()}

  @callback read!(bus(), address(), pos_integer(), [opt()]) :: binary()

  @callback write(bus(), address(), iodata(), [opt()]) :: :ok | {:error, term()}

  @callback write!(bus(), address(), iodata(), [opt()]) :: :ok

  @callback write_read(bus(), address(), iodata(), pos_integer(), [opt()]) ::
              {:ok, binary()} | {:error, term()}
  @callback write_read(bus(), address(), iodata(), pos_integer()) ::
              {:ok, binary()} | {:error, term()}

  @callback write_read!(bus(), address(), iodata(), pos_integer(), [opt()]) :: binary()
  @callback close(bus()) :: :ok
  @callback bus_names() :: [binary()]

  @callback detect_devices(bus() | binary()) :: [address()] | {:error, term()}

  @callback detect_devices() :: :"do not show this result in output"
  @callback discover([address()], present?()) :: [{binary(), address()}]

  @callback discover_one([address()], present?()) ::
              {:ok, {binary(), address()}} | {:error, :not_found | :multiple_possible_matches}

  @callback discover_one!([address()], present?()) :: {binary(), address()}

  @callback device_present?(bus(), address()) :: boolean()
  @callback info() :: map()
end
