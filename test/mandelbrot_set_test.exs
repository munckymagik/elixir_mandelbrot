defmodule MandelbrotSetTest do
  use ExUnit.Case
  @epsilon 0.1e-14

  test "#count_iterations: returns the number of iterations needed to  " <>
       "prove c is not a member of the Mandelbrot set" do
    not_in_the_set = Complex.new(1, 0)
    assert MandelbrotSet.count_iterations(not_in_the_set, 100) == 3
  end

  test "#count_iterations: returns max_iterations if exclusion from the " <>
       "Mandelbrot set cannot be proven within max_iterations iterations" do
    in_the_set = Complex.new(-1, 0)
    assert MandelbrotSet.count_iterations(in_the_set, 100) == 100
  end

  test "#apply_polynomial" do
    z = Complex.new(1, 1)
    c = Complex.new(1, 1)
    assert MandelbrotSet.apply_polynomial(z, c) == Complex.new(1, 3)
  end

  test "#iterate_until: iterates until `stop_iterating?` returns true" do
    c = Complex.new(1, 1)
    stop_iterating? = fn (_z, _iteration_count) -> true end

    assert MandelbrotSet.iterate_until(c, stop_iterating?) == 0
  end

  test "#iterate_until: returns the number of iterations reached" do
    c = Complex.new(1, 1)
    stop_iterating? = fn (_z, iteration_count, max_iterations) ->
      iteration_count >= max_iterations
    end
    stop_at_1 = &(stop_iterating?.(&1, &2, 1))
    stop_at_2 = &(stop_iterating?.(&1, &2, 2))

    assert MandelbrotSet.iterate_until(c, stop_at_1) == 1
    assert MandelbrotSet.iterate_until(c, stop_at_2) == 2
  end

  test "#unbounded?: returns true if absolute value of z is greater than 2" do
    # Evaluates to the smallest amount less than 2
    bounded = Complex.new(2 - @epsilon, 0)
    assert bounded |> Complex.mod <= 2
    refute bounded |> MandelbrotSet.unbounded?

    # Evaluates to 2 exactly
    bounded = Complex.new(2, 0)
    assert bounded |> Complex.mod <= 2
    refute bounded |> MandelbrotSet.unbounded?

    # Evaluates to the smallest amount greater than 2
    unbounded = Complex.new(2 + @epsilon, 0)
    assert unbounded |> Complex.mod > 2
    assert unbounded |> MandelbrotSet.unbounded?
  end
end
