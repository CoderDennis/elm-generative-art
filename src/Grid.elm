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
import Draw exposing (translate, transform, zipCycle3)
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


draw : Grid -> List (List (Svg.Attribute a)) -> List String -> Svg a -> Svg a
draw grid attrs transforms thing =
    let
        l =
            zipCycle3 grid.points attrs transforms
    in
        g []
            (l
                |> List.map (placeAtPoint grid.segmentLength thing)
            )


placeAtPoint : Float -> Svg a -> ( Point, List (Svg.Attribute a), String ) -> Svg a
placeAtPoint segmentLength thing ( ( x, y ), attrs, transforms ) =
    g
        ((transform
            [ translate ((toFloat x) * segmentLength) ((toFloat y) * segmentLength)
            , transforms
            ]
         )
            :: attrs
        )
        [ thing ]
