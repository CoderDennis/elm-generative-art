module GridTests exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)
import Grid exposing (..)


suite : Test
suite =
    describe "The Grid module"
        [ test "2 x 3 grid" <|
            \_ ->
                init 2 3 1
                    |> .points
                    |> Expect.equal [ ( 0, 0 ), ( 0, 1 ), ( 0, 2 ), ( 1, 0 ), ( 1, 1 ), ( 1, 2 ) ]
        , test "3 x 2 grid" <|
            \_ ->
                init 3 2 1
                    |> .points
                    |> Expect.equal [ ( 0, 0 ), ( 0, 1 ), ( 1, 0 ), ( 1, 1 ), ( 2, 0 ), ( 2, 1 ) ]
        ]
