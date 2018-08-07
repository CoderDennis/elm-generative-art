module Main exposing (..)

import Html exposing (Html)
import Svg exposing (Svg, svg, g)
import Svg.Attributes as Attributes
import Grid exposing (..)
import Draw exposing (circle)


type alias Model =
    { width : Float
    , height : Float
    , grid : Grid
    }


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    let
        width =
            1600

        height =
            900

        segmentLength =
            50

        grid =
            makeGrid width height segmentLength
    in
        ( { width = width
          , height = height
          , grid = grid
          }
        , Cmd.none
        )


view : Model -> Html Msg
view model =
    svg
        [ Attributes.viewBox <|
            "0 0 "
                ++ (toString <| model.width + 100)
                ++ " "
                ++ (toString <| model.height + 100)
        , Attributes.preserveAspectRatio "xMidYMid meet"
        , Attributes.height "100%"
        , Attributes.width "100%"
        , Attributes.stroke "black"
        , Attributes.strokeLinecap "round"
        , Attributes.strokeLinejoin "round"
        , Attributes.strokeWidth "5"
        ]
        [ g
            [ Attributes.transform "translate(50,50)" ]
            [ (circle 25 25 5)
                |> drawInGrid model.grid
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
