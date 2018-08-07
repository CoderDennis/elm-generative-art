module GridTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Grid exposing (..)


suite : Test
suite =
    describe "The Grid module"
        [ test "2 x 3 grid" <|
            \_ ->
                makeGrid 2 3
                    |> Expect.equal [ ( 0, 0 ), ( 0, 1 ), ( 0, 2 ), ( 1, 0 ), ( 1, 1 ), ( 1, 2 ) ]
        , test "3 x 2 grid" <|
            \_ ->
                makeGrid 3 2
                    |> Expect.equal [ ( 0, 0 ), ( 0, 1 ), ( 1, 0 ), ( 1, 1 ), ( 2, 0 ), ( 2, 1 ) ]
        ]
