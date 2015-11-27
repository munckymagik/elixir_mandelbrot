defmodule Complex do
  @moduledoc """
  A simple attempt at complex numbers
  """
  defstruct re: 0, im: 0

  def new(re, im) when is_number(re) and is_number(im) do
    %__MODULE__{re: re, im: im}
  end

  def add(a = %__MODULE__{}, b = %__MODULE__{}) do
    new(a.re + b.re, a.im + b.im)
  end

  def subtract(a = %__MODULE__{}, b = %__MODULE__{}) do
    new(a.re - b.re, a.im - b.im)
  end

  def multiply(a = %__MODULE__{}, b = %__MODULE__{}) do
    re = (a.re * b.re) + (a.im * b.im * -1)
    im = (a.re * b.im) + (b.re * a.im)
    new(re, im)
  end

  def mod(a = %__MODULE__{}) do
    :math.sqrt(a.re * a.re + a.im * a.im)
  end
end