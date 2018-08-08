module Grid
    exposing
        ( Grid
        , init
        , draw
        , pointCount
        )

import List
import Svg exposing (Svg, g)
import Svg.Attributes as Attributes
import Draw exposing (translate)
import List.Extra exposing (zip)


type alias Point =
    ( Int, Int )


type alias Grid =
    { points : List Point
    , segmentLength : Float
    }


pointCount : Grid -> Int
pointCount grid =
    List.length grid.points


init : Float -> Float -> Float -> Grid
init width height segmentLength =
    let
        segmentsWide =
            floor <| width / segmentLength

        segmentsHigh =
            floor <| height / segmentLength

        xs =
            List.range 0 (segmentsWide - 1)

        ys =
            List.range 0 (segmentsHigh - 1)
    in
        { points = cartesian xs ys
        , segmentLength = segmentLength
        }


cartesian : List a -> List b -> List ( a, b )
cartesian xs ys =
    List.concatMap
        (\x -> List.map (\y -> ( x, y )) ys)
        xs


draw : Grid -> List (Svg.Attribute a) -> Svg a -> Svg a
draw grid attrs thing =
    let
        l =
            zip grid.points attrs
    in
        g []
            (l
                |> List.map (placeAtPoint grid.segmentLength thing)
            )


placeAtPoint : Float -> Svg a -> ( Point, Svg.Attribute a ) -> Svg a
placeAtPoint segmentLength thing ( ( x, y ), attr ) =
    g
        [ translate ((toFloat x) * segmentLength) ((toFloat y) * segmentLength)
        , attr
        ]
        [ thing ]
