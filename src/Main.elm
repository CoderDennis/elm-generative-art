module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value)
import Svg exposing (Svg, svg, g)
import Svg.Attributes as Attributes
import Grid exposing (Grid)
import Draw exposing (..)
import DistinctColors.HSLuv exposing (randomColor)
import Color exposing (Color)
import Random.Pcg as Random


type alias Model =
    { width : Float
    , height : Float
    , grid : Grid
    , shape : Svg Msg
    , shapeEdit : ShapeEdit
    , colors : List Color
    }


type Msg
    = CircleMsg String
    | RectangleMsg String String
    | LineMsg String String
    | Colors (List Color)


type ShapeEdit
    = Circle String
    | Rectangle String String
    | Line String String


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
            Grid.init width height segmentLength

        colorOptions =
            { saturation = 1.0
            , lightness = 0.7
            , alpha = 1.0
            }
    in
        ( { width = width
          , height = height
          , grid = grid
          , shape = circle 25 25 20
          , shapeEdit = Circle "20"
          , colors = []
          }
        , Random.generate Colors <| Random.list (Grid.pointCount grid) (randomColor colorOptions)
        )


view : Model -> Html Msg
view model =
    div []
        [ viewShapeEdit model.shapeEdit
        , svg
            [ Attributes.viewBox <|
                "0 0 "
                    ++ (toString <| model.width + 100)
                    ++ " "
                    ++ (toString <| model.height + 100)
            , Attributes.preserveAspectRatio "xMidYMid meet"
            , Attributes.height "100%"
            , Attributes.width "100%"
            , Attributes.stroke "black"
            ]
            [ g
                [ Attributes.transform "translate(50,50)" ]
                [ (model.shape)
                    |> Grid.draw model.grid (mapColors model.colors)
                ]
            ]
        ]


viewShapeEdit : ShapeEdit -> Html Msg
viewShapeEdit shapeEdit =
    div []
        [ button
            [ onClick <| CircleMsg "5"
            ]
            [ text "Circle" ]
        , button
            [ onClick <| RectangleMsg "32" "18"
            ]
            [ text "Rectangle" ]
        , button
            [ onClick <| LineMsg "55" "25"
            ]
            [ text "Line" ]
        , viewShapeValues shapeEdit
        ]


viewShapeValues : ShapeEdit -> Html Msg
viewShapeValues shapeEdit =
    case shapeEdit of
        Circle r ->
            div []
                [ text "Radius: "
                , input
                    [ onInput <| CircleMsg
                    , value r
                    ]
                    []
                ]

        Rectangle width height ->
            div []
                [ text "Width: "
                , input
                    [ onInput (\v -> RectangleMsg v height)
                    , value width
                    ]
                    []
                , text "Height: "
                , input
                    [ onInput <| RectangleMsg width
                    , value height
                    ]
                    []
                ]

        Line x2 y2 ->
            div []
                [ text "x2: "
                , input
                    [ onInput (\v -> LineMsg v y2)
                    , value x2
                    ]
                    []
                , text "y2: "
                , input
                    [ onInput <| LineMsg x2
                    , value y2
                    ]
                    []
                ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CircleMsg r ->
            ( { model
                | shape = circle 25 25 (inputToFloat r)
                , shapeEdit = Circle r
              }
            , Cmd.none
            )

        RectangleMsg width height ->
            ( { model
                | shape = rect 0 0 (inputToFloat width) (inputToFloat height)
                , shapeEdit = Rectangle width height
              }
            , Cmd.none
            )

        LineMsg x2 y2 ->
            ( { model
                | shape = line 0 0 (inputToFloat x2) (inputToFloat y2)
                , shapeEdit = Line x2 y2
              }
            , Cmd.none
            )

        Colors cs ->
            ( { model | colors = cs }, Cmd.none )


inputToFloat : String -> Float
inputToFloat value =
    Result.withDefault 0 (String.toFloat value)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
