defmodule Geometry do
  @moduledoc false

  defmodule ComplexPlane do
    @moduledoc """
    Represents a complex plane.

    This is essentially two complex numbers interpreted as two points to
    represent a rectangular area.

    ```
    (re0,im0)------------+
    |                    |
    +------------(re1,im1)
    ```
    """
    defstruct re0: 0, im0: 0, re1: 0, im1: 0
  end

  defmodule Rectangle do
    @moduledoc """
    Represents a rectangle defined by a width and a height.

    ```
    +--------(w)---------+
    (h)                  |
    +--------------------+
    ```
    """
    defstruct h: 0, w: 0
  end
end
