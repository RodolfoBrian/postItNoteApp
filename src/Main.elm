module Main exposing (..)

import Browser
import Html exposing (Html, button, div, form, input, text)
import Html.Attributes exposing (class, style, type_)
import Html.Events exposing (onClick)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


init : Model
init =
    { noteInput = "", postIts = [] }


update : Msg -> Model -> Model
update msg model =
    init


type Msg
    = AddPostIt String
    | Move Position
    | Delete Int
    | Edit


type alias Position =
    { x : Int, y : Int }


type alias Colour =
    { r : Int, g : Int, b : Int, a : Int }


type alias PostIt =
    { position : Position
    , colour : Colour
    , note : String
    , id : Int
    }


type alias Model =
    { noteInput : String, postIts : List PostIt }



-- view : a


view : Model -> Html Msg
view model =
    div
        [ style "background-color" "green"
        , style "min-width" "100vw"
        , style "min-height" "100vh"
        ]
        [ postItForm

        -- , postItBoard
        ]


postItForm =
    form
        []
        [ input [ type_ "text" ] []
        , button [ type_ "submit" ] [ text "Add postit" ]
        ]



-- postItBoard =
--     div [] []
