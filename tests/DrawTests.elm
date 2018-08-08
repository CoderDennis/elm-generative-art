module DrawTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Draw exposing (..)


suite : Test
suite =
    describe "The Draw module"
        [ test "zipCycle" <|
            \_ ->
                zipCycle [ 1, 2, 3 ] [ 'a', 'b' ]
                    |> Expect.equal [ ( 1, 'a' ), ( 2, 'b' ), ( 3, 'a' ) ]
        ]
