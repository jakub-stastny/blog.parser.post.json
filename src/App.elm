module App exposing (main)

import Debug

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, ul, li, a)
import Html.Attributes exposing (href)
import Url

import Element exposing (el, layout, row, rgb255, text, padding, spacing)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font

constants = {title = "My blog"}

main : Program () Model Msg
main =
  Browser.application
    { init = init,
      view = view,
      update = update,
      subscriptions = subscriptions,
      onUrlChange = UrlChanged,
      onUrlRequest = LinkClicked
    }

type alias Model = { key : Nav.Key, url : Url.Url }

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key = ( Model key url, Cmd.none )

type Msg = LinkClicked Browser.UrlRequest | UrlChanged Url.Url

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | url = url }, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

view : Model -> {title: String, body: List (Html Msg)}
view model =
  { title = "My blog",
    body = [
      layout [] (
        row [ spacing 30 ] [
          el [
            Background.color (rgb255 240 0 245)
          ]
          (text ("Current URL: " ++ Url.toString model.url)),
          Element.html <| ul [] [
            viewLink "/",
            viewLink "/about",
            viewLink "/contact"
          ]
        ]
      )
    ]
  }

viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ Html.text path ] ]
