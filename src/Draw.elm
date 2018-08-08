module Draw exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attributes
import Color exposing (Color)
import Color.Convert exposing (colorToHex)


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
        , Attributes.strokeWidth "0"
        ]
        []


rect : Float -> Float -> Float -> Float -> Svg a
rect x y width height =
    Svg.rect
        [ Attributes.x <| toString x
        , Attributes.y <| toString y
        , Attributes.width <| toString width
        , Attributes.height <| toString height
        , Attributes.strokeWidth "0"
        ]
        []


translate : Float -> Float -> Svg.Attribute a
translate x y =
    Attributes.transform <| "translate(" ++ toString x ++ "," ++ toString y ++ ")"


mapColors : List Color -> List (List (Svg.Attribute a))
mapColors colors =
    let
        colorToAttr c =
            [ Attributes.fill <| colorToHex c ]
    in
        List.map colorToAttr colors
