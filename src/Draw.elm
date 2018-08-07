module Draw exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attributes


line : Float -> Float -> Float -> Float -> Svg a
line x1 y1 x2 y2 =
    Svg.line
        [ Attributes.x1 <| toString x1
        , Attributes.y1 <| toString y1
        , Attributes.x2 <| toString x2
        , Attributes.y2 <| toString y2
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


translate : Float -> Float -> Svg.Attribute a
translate x y =
    Attributes.transform <| " translate(" ++ toString x ++ "," ++ toString y ++ ") "
