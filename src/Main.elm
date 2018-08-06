module Main exposing (..)

import Html exposing (Html)
import Svg exposing (Svg, svg, g)
import Svg.Attributes as Attributes
import Draw exposing (..)


type alias Model =
    {}


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )


view : Model -> Html Msg
view model =
    svg
        [ Attributes.viewBox "0 0 1100 1100"
        , Attributes.preserveAspectRatio "xMidYMid meet"
        , Attributes.height "100%"
        , Attributes.width "100%"
        , Attributes.strokeWidth "1"
        , Attributes.stroke "black"
        ]
        [ g
            [ Attributes.transform "translate(50,50)" ]
            [ line 0 0 1000 0
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
