module Grid
    exposing
        ( Grid
        , makeGrid
        , drawInGrid
        )

import List
import Svg exposing (Svg, g)
import Svg.Attributes as Attributes
import Draw exposing (translate)


type alias Point =
    ( Int, Int )


type alias Grid =
    { points : List Point
    , segmentLength : Int
    }


makeGrid : Int -> Int -> Int -> Grid
makeGrid width height segmentLength =
    let
        xs =
            List.range 0 (width - 1)

        ys =
            List.range 0 (height - 1)
    in
        { points = cartesian xs ys
        , segmentLength = segmentLength
        }


cartesian : List a -> List b -> List ( a, b )
cartesian xs ys =
    List.concatMap
        (\x -> List.map (\y -> ( x, y )) ys)
        xs


drawInGrid : Grid -> Svg a -> Svg a
drawInGrid grid thing =
    g []
        (grid.points
            |> List.map (placeAtPoint grid.segmentLength thing)
        )


placeAtPoint : Int -> Svg a -> Point -> Svg a
placeAtPoint segmentLength thing ( x, y ) =
    g
        [ translate (toFloat <| x * segmentLength) (toFloat <| y * segmentLength) ]
        [ thing ]
