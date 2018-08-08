module Draw exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attributes
import Color exposing (Color)
import Color.Convert exposing (colorToHex)
import List.Extra exposing (cycle, zip, zip3)


line : Float -> Float -> Float -> Float -> Svg a
line x1 y1 x2 y2 =
    Svg.line
        [ Attributes.x1 <| toString x1
        , Attributes.y1 <| toString y1
        , Attributes.x2 <| toString x2
        , Attributes.y2 <| toString y2
        , Attributes.strokeLinecap "round"
        , Attributes.strokeLinejoin "round"
        , Attributes.strokeWidth "5"
        ]
        []


circle : Float -> Float -> Float -> Svg a
circle x y r =
    Svg.circle
        [ Attributes.cx <| toString x
        , Attributes.cy <| toString y
        , Attributes.r <| toString r
        ]
        []


rect : Float -> Float -> Float -> Float -> Svg a
rect x y width height =
    Svg.rect
        [ Attributes.x <| toString x
        , Attributes.y <| toString y
        , Attributes.width <| toString width
        , Attributes.height <| toString height
        ]
        []


translate : Float -> Float -> String
translate x y =
    " translate(" ++ toString x ++ "," ++ toString y ++ ") "


rotate : Float -> Float -> String
rotate size degrees =
    let
        sizeMidPoint =
            toString <| size / 2
    in
        " rotate(" ++ toString degrees ++ "," ++ sizeMidPoint ++ "," ++ sizeMidPoint ++ ") "


transform : List String -> Svg.Attribute a
transform xs =
    xs
        |> String.concat
        |> Attributes.transform


mapColors : List Color -> List (List (Svg.Attribute a))
mapColors colors =
    let
        colorToAttr c =
            let
                h =
                    colorToHex c
            in
                [ Attributes.fill h
                , Attributes.stroke h
                ]
    in
        List.map colorToAttr colors


{-| Take two lists and returns a list of correspoinding pairs.
The 2nd list will be cycled or trimmed to match length of 1st list.
-}
zipCycle : List a -> List b -> List ( a, b )
zipCycle a b =
    let
        length =
            List.length a

        bCycled =
            cycle length b
    in
        zip a bCycled


zipCycle3 : List a -> List b -> List c -> List ( a, b, c )
zipCycle3 a b c =
    let
        length =
            List.length a

        bCycled =
            cycle length b

        cCycled =
            cycle length c
    in
        zip3 a bCycled cCycled
