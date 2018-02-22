module TalkToMe exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src, placeholder, type_, value, disabled)
import Html.Events exposing (onClick, onInput, onSubmit)
import Json.Decode exposing (Decoder, bool, decodeString, int, list, string)
import Json.Decode.Pipeline exposing (decode, hardcoded, required)
import Http
import Debug

type alias Id = Int

type alias Model = { id: Id }
    
type Msg
    = SpellToMe Id
    | SayToMe Id

-----------------------------------------------------

initialModel =
    { id = 0 }

------------------------------------------------

fetchDict : Cmd Msg
fetchDict =
    Http.get "" |> Http.send Cmd.none

errorMessage : Http.Error -> String
errorMessage err =
    case err of
        Http.BadPayload _ _ ->
            """Sorry, we couldn't process your request at this time. We're working on it!"""
        _ ->
            """Sorry, we couldn't load your request at this time. Please try again later."""

view : Model -> Html Msg
view model =
    div []
        []
                
------------------------------------------------

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SpellToMe id -> ({model | id = id }, Cmd.none)
        SayToMe id -> ({ model | id = id }, Cmd.none)

-------------------------------------------------

init : (Model, Cmd Msg)
init =
    (initialModel, fetchDict)

-------------------------------------------------

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        }

        
