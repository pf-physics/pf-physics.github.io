module APIPage exposing (..)

import Browser
import Html.Events exposing (onClick)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Browser
import Http
import Json.Decode exposing (Decoder, field, string, map2)
import Json.Encode
import Css

-- MODEL

type alias Model =
  { nasaImage : ApiStatus NasaImage
  , randomJoke : ApiStatus Joke
  }

type ApiStatus a
  = Failure Http.Error
  | Loading
  | Success a


init : () -> (Model, Cmd Msg)
init _ =
  ( Model Loading Loading
  , Cmd.batch
   [ Http.get
      { url = "https://api.nasa.gov/planetary/apod?api_key=E5I1roOsvZvSKbJFALNAnoHqD12FNcmL8uoARAd3"
      , expect = Http.expectJson GotImage imageDecoder
      }
    , Http.get
      { url = "https://v2.jokeapi.dev/joke/Spooky?type=twopart?blacklistFlags=nsfw,racist,sexist,explicit"
      , expect = Http.expectJson GotJoke randomJokeDecoder
      }
  ]
  )



-- UPDATE

type Msg
  = GotImage (Result Http.Error NasaImage)
  | GotJoke (Result Http.Error Joke)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotImage result ->
      case result of
        Ok image ->
          ( { model | nasaImage = (Success image) } , Cmd.none )

        Err e ->
          ( { model | nasaImage = (Failure e) }, Cmd.none)

    GotJoke result ->
      case result of
        Ok res ->
          ( { model | randomJoke = (Success res) } , Cmd.none )

        Err e ->
          ( { model | randomJoke = (Failure e) }, Cmd.none)


-- VIEW


imageDecoder: Decoder NasaImage
imageDecoder = map2 NasaImage (field "url" string) (field "media_type" string)


type alias NasaImage =
  { url : String
  , mediaType : String
  }

type alias Joke =
  { setup: String
  , delivery: String
  }

randomJokeDecoder: Decoder Joke
randomJokeDecoder = map2 Joke (field "setup" string) (field "delivery" string)



view : Model -> Html Msg
view model =
  div [] [
  div [style "text-align" "center"]
    [ h1 [] [ text "API page" ]
    , p [] [ text "On this page I put some fun apis I like."]
    , div [ style "border" "3px solid white"
          , style "border-radius" "10px"
          , style "width" "500px"
          , style "margin" "auto"
          ]
      [ h2 [] [ text "Random (spooky) joke"]
      , (case model.randomJoke of
          Failure e ->
            case e of
              Http.BadStatus status ->
                p []
                [ h3 [] [ text "There was an error getting the joke with status:" ]
                , img [src ("https://http.cat/" ++ String.fromInt status)] []
                ]
              _ ->
                text "Error loading joke"

          Loading ->
            text "Loading..."

          Success joke ->
              div []
              [ h4 [] [ text joke.setup ]
              , h4 [] [ text joke.delivery ]
              ]
        )
    ]
    , h3 [] [ text "Nasa Daily Image" ]
    , (
    case model.nasaImage of
    Failure e ->
      case e of
        Http.BadStatus status ->
          p []
          [ h2 [] [ text "There was an error getting the image with status:" ]
          , img [src ("https://http.cat/" ++ String.fromInt status)] []
          ]
        _ ->
          text "Error loading image"

    Loading ->
      text "Loading..."

    Success image ->
        if image.mediaType == "video"
        then
          (iframe
            [ width 560
            , height 315
            , css [ Css.marginBottom (Css.px 30)]
            , src image.url
            , property "frameborder" (Json.Encode.string "0")
            , property "allowfullscreen" (Json.Encode.string "true")
            ]
            [])
        else img [src (image.url)] []
      )
    ]
  ]