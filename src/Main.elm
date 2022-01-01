module Main exposing (..)

import Browser
import Html exposing (Html, a, button, div, form, input, text)
import Html.Attributes exposing (class, id, style, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)


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
    case msg of
        NoteInput addTxt ->
            { model
                | noteInput = addTxt
            }

        AddPostIt ->
            { model | postIts = createPostIt model.noteInput :: model.postIts, noteInput = "" }

        _ ->
            model


createPostIt : String -> PostIt
createPostIt postit =
    let
        position =
            Position 0 0

        colour =
            Colour 255 45 45 0.5
    in
    PostIt position colour postit 0


type Msg
    = AddPostIt
    | Move Position
    | Delete Int
    | Edit
    | NoteInput String


type alias Position =
    { x : Int, y : Int }


type alias Colour =
    { red : Int, green : Int, blue : Int, alpha : Float }


type alias PostIt =
    { position : Position
    , colour : Colour
    , note : String
    , id : Int
    }


type alias Model =
    { noteInput : String, postIts : List PostIt }



-- view : a
--}


buttonStyle : List (Html.Attribute msg)
buttonStyle =
    [ style "width" "300px"
    , style "background-color" "#397cd5"
    , style "color" "yellow"
    , style "padding" "14px 20px"
    , style "margin-top" "10px"
    , style "border" "none"
    , style "border-radius" "4px"
    , style "font-size" "16px"
    ]


inputStyle : List (Html.Attribute msg)
inputStyle =
    [ style "width" "300px"
    , style "padding" "14px 20px"
    , style "margin" "10px"
    , style "font-size" "16px"
    ]



-- view : Model -> Html Msg


view model =
    div
        [ style "background-color" "#232323"
        , style "min-width" "100vw"
        , style "min-height" "100vh"
        ]
        [ postItForm model
        , postItBoard model.postIts
        ]


postItForm model =
    form
        []
        [ input ([ type_ "text", value model.noteInput, onInput NoteInput ] ++ inputStyle) []
        , a ([ onClick AddPostIt ] ++ buttonStyle) [ text "Add Post It" ]
        ]


postItBoard notes =
    div
        [ style "width" "500px"
        , style "height" "500px"
        , style "margin" "25px"
        , style "padding" "25px"
        , style "background-color" "#ffffff"
        ]
        (List.map postToDiv notes)


postToDiv note =
    let
        x =
            String.fromInt note.position.x ++ "px"

        y =
            String.fromInt note.position.y ++ "px"

        rgba =
            "rgba("
                ++ String.fromInt note.colour.red
                ++ ","
                ++ String.fromInt note.colour.green
                ++ ","
                ++ String.fromInt note.colour.blue
                ++ ","
                ++ String.fromFloat note.colour.alpha
                ++ ")"

        _ =
            Debug.log "Anything..." rgba
    in
    div
        [ style "position"
            "relative"
        , style
            "baground-color"
            rgba
        , style
            "left"
            x
        , style
            "top"
            y
        , id (String.fromInt note.id)
        ]
        [ text note.note ]



{- To do:  Fix Colour -}
