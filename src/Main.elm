module Main exposing (main)

import Browser
import File exposing (File)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D


type alias Flags =
    {}


type alias Model =
    { files : List File
    }


type Msg
    = GotFiles (List File)


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { files = []
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotFiles files ->
            ( { model | files = files }, Cmd.none )


view : Model -> Html Msg
view model =
    input
        [ on "change" (D.map GotFiles filesDecoder)
        , type_ "file"
        , multiple True
        ]
        []


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none


filesDecoder : D.Decoder (List File)
filesDecoder =
    D.at [ "target", "files" ] (D.list File.decoder)
